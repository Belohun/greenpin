import 'package:greenpin/data/test/api/test_api_data_source.dart';
import 'package:greenpin/domain/test/test_api_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: TestApiRepository)
class TestApiRepositoryImpl extends TestApiRepository {
  TestApiRepositoryImpl(this._dataSource);

  final TestApiDataSource _dataSource;

  @override
  Future test() => _dataSource.test();
}
