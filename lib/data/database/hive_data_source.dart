import 'package:greenpin/data/database/hive_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDataSource<T extends HiveEntity<T>> {
  final Box<T> _hiveBox;

  HiveDataSource(this._hiveBox);

  Future create(T input) async {
    return _hiveBox.put(input.uuid, input);
  }

  Future delete(String id) async {
    return _hiveBox.delete(id);
  }

  Future<List<T>> all() async {
    return _hiveBox.values.toList();
  }

  Future update(T input) async {
    return _hiveBox.put(input.uuid, input);
  }

}
