import 'package:bloc/bloc.dart';
import 'package:greenpin/domain/product/use_case/get_all_local_products_use_case.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/page/cart_page/cubit/cart_data.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:injectable/injectable.dart';

part 'cart_state.dart';

part 'cart_cubit.freezed.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  CartCubit(this._getAllLocalProductsUseCase)
      : super(const CartState.loading());

  final GetAllLocalProductsUseCase _getAllLocalProductsUseCase;

  late CartData _data;

  Future<void> init() async {
    final products = await _getAllLocalProductsUseCase();
    _data = CartData(products: products);
    emit(CartState.idle(_data));
  }
}
