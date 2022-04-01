import 'package:greenpin/data/register/mapper/register_page_data_to_register_dto_mapper.dart';
import 'package:greenpin/domain/networking/safe_response/safe_response.dart';
import 'package:greenpin/domain/register/register_repository.dart';
import 'package:greenpin/presentation/page/register_page/model/register_page_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUserUseCase {
  RegisterUserUseCase(
    this._repository,
    this._mapper,
  );

  final RegisterRepository _repository;
  final RegisterPageDataToRegisterDtoMapper _mapper;

  Future<SafeResponse<void>> call(RegisterPageData data) {
    final dto = _mapper(data);
    return _repository.register(dto);
  }
}
