
abstract class LocalSingleStore<T> {
  Future create(T value);

  Future<T?> read();

  Future update(T value);

  Future delete(T value);

  Future clear();

}
