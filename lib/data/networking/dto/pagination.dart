import 'package:greenpin/data/networking/dto/sort_enum.dart';
import 'package:greenpin/exports.dart';

part 'pagination.g.dart';

const standardPageSize = 10;

@JsonSerializable()
class Pagination {
  Pagination({
    required this.size,
    required this.page,
    required this.sort,
  });

  final int page;
  final int size;
  final List<SortEnum> sort;

  factory Pagination.standardPage(int page) => Pagination(
        size: standardPageSize,
        page: page,
        sort: [SortEnum.asc],
      );

  @override
  String toString() => 'page=$page&size=$size$sortString';

  String get sortString {
    var sortString = '';
    for (final element in sort) {
      sortString = sortString + '&sort=${element.name}';
    }
    return sortString;
  }

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
