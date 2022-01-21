import 'package:greenpin/data/test/dto/register_dto.dart';
import 'package:greenpin/domain/networking/safe_response/safe_response.dart';

abstract class RegisterRepository {
  Future<SafeResponse<void>> register(RegisterDto dto);
}