import 'package:github_poc/data/dto/repository_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_repositories_response_dto.g.dart';

@JsonSerializable()
class SearchRepositoriesResponseDto {
  const SearchRepositoriesResponseDto({
    required this.totalCount,
    required this.incompleteResults,
    required this.items,
  });

  factory SearchRepositoriesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SearchRepositoriesResponseDtoFromJson(json);

  @JsonKey(name: 'total_count')
  final int totalCount;
  @JsonKey(name: 'incomplete_results')
  final bool incompleteResults;
  final List<RepositoryDto> items;

  Map<String, dynamic> toJson() => _$SearchRepositoriesResponseDtoToJson(this);
}
