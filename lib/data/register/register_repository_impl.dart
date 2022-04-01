import 'package:greenpin/data/register/api/register_data_source.dart';
import 'package:greenpin/data/register/dto/register_dto.dart';
import 'package:greenpin/domain/networking/safe_response/safe_response.dart';
import 'package:greenpin/domain/register/register_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: RegisterRepository)
class RegisterRepositoryImpl extends RegisterRepository {
  RegisterRepositoryImpl(this._registerDataSource);

  final RegisterDataSource _registerDataSource;

  @override
  Future<SafeResponse<void>> register(RegisterDto dto) =>
      fetchSafety(() => _registerDataSource.register(dto));
}
