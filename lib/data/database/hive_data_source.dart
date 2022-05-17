import 'package:greenpin/data/database/hive_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDataSource<T extends HiveEntity<T>> {
  final Box<T> _hiveBox;

  HiveDataSource(this._hiveBox);

  Future<void> create(T input) => _hiveBox.put(input.uuid, input);

  Future<void> delete(String id) => _hiveBox.delete(id);

  Future<List<T>> all() async => _hiveBox.values.toList();

  Future<void> update(T input) => _hiveBox.put(input.uuid, input);

  Future<void> clear() => _hiveBox.clear();
}
