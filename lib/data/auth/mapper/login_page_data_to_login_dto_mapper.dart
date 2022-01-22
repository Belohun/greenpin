import 'package:greenpin/data/auth/dto/login_dto.dart';
import 'package:greenpin/data/common/data_mapper.dart';
import 'package:greenpin/presentation/page/login_page/model/login_page_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginPageDataToLoginDtoMapper
    extends DataMapper<LoginPageData, LoginDto> {
  @override
  LoginDto call(LoginPageData data) {
    return LoginDto(
      password: data.password ?? '',
      email: data.email ?? '',
    );
  }
}
