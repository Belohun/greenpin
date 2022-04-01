enum SortEnum {
  desc,
  asc,
}

extension SortEnumExtension on SortEnum {
  String get valueString {
    switch (this) {
      case SortEnum.desc:
        return 'desc';
      case SortEnum.asc:
        return 'asc';
    }
  }
}
