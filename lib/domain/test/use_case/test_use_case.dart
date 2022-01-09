import 'package:greenpin/domain/test/test_api_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class TestUseCase {
  TestUseCase(this._testApiRepository);

  final TestApiRepository _testApiRepository;

  Future call() => _testApiRepository.test();
}
