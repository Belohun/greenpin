
extension IterableExtension<T> on Iterable<T> {
  T? get firstOrNull {
    try {
      return first;
    } catch (e) {
      return null;
    }
  }

  T? firstWhereOrNull(bool Function(T element) function) {
    try {
      return firstWhere(function);
    } catch (e) {
      return null;
    }
  }

  Iterable<E> mapWhere<E>(E Function(T element) f, bool Function(T element) condition) {
    final whereIterable = where(condition);
    return whereIterable.map(f);
  }

  Iterable<E> mapOnlyOnSuccess<E>(E Function(T element) f) {
    Iterable<E> _iterable = [];
    for (final element in this) {
      try {
        _iterable = [..._iterable, f(element)];
      } catch (e) {
        print('mapOnlyOnSuccess: $e');
      }
    }
    return _iterable;
  }
  bool containsWhere( bool Function(T element) function){
    final element =  firstWhereOrNull(function);
    return element != null;
  }
}

extension NullableIterableExtensions<T> on Iterable<T>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}
