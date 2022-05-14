
abstract class LocalStore<T> {
  Future create(T value);

  Future<List<T>> readAll();

  Future update(T value);

  Future delete(T value);

  Stream<bool> get stream;

  void addToStream(bool value);
}
