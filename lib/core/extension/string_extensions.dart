extension NullableStringExtension on String? {
  bool get isNotEmptyAndNull => this?.isNotEmpty ?? false;
}