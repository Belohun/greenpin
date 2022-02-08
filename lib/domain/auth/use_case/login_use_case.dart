import 'package:greenpin/core/di_config.dart';
import 'package:greenpin/data/auth/mapper/login_page_data_to_login_dto_mapper.dart';
import 'package:greenpin/data/auth/mapper/user_token_mapper.dart';
import 'package:greenpin/data/user/provider/user_info_provider_impl.dart';
import 'package:greenpin/domain/auth/repository/auth_repository.dart';
import 'package:greenpin/domain/auth/store/auth_store.dart';
import 'package:greenpin/domain/networking/safe_response/safe_response.dart';
import 'package:greenpin/presentation/page/login_page/model/login_page_data.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class LoginUseCase {
  LoginUseCase(
    this._authStore,
    this._authRepository,
    this._dataToLoginDtoMapper,
    this._userTokenMapper,
  );

  final LoginPageDataToLoginDtoMapper _dataToLoginDtoMapper;
  final UserTokenMapper _userTokenMapper;
  final AuthRepository _authRepository;
  final AuthStore _authStore;

  Future<SafeResponse<void>> call(LoginPageData data) => fetchSafety(
        () async {
          final dto = _dataToLoginDtoMapper(data);
          final userTokenDto = await _authRepository.login(dto);
          final userToken = _userTokenMapper.from(userTokenDto);
          await _authStore.saveUserToken(userToken);
          await getIt.getAsync<UserInfoProvider>();
        },
      );
}
