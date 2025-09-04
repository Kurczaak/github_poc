import 'package:github_poc/data/dto/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'repository_dto.g.dart';

@JsonSerializable()
class RepositoryDto {
  const RepositoryDto({
    required this.id,
    required this.name,
    required this.fullName,
    required this.description,
    required this.stargazersCount,
    required this.forksCount,
    required this.language,
    required this.htmlUrl,
    required this.updatedAt,
    required this.owner,
  });

  factory RepositoryDto.fromJson(Map<String, dynamic> json) =>
      _$RepositoryDtoFromJson(json);

  final int id;
  final String name;
  @JsonKey(name: 'full_name')
  final String fullName;
  final String? description;
  @JsonKey(name: 'stargazers_count')
  final int stargazersCount;
  @JsonKey(name: 'forks_count')
  final int forksCount;
  final String? language;
  @JsonKey(name: 'html_url')
  final String htmlUrl;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  final UserDto owner;

  Map<String, dynamic> toJson() => _$RepositoryDtoToJson(this);
}
