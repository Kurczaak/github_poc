import 'package:github_poc/data/dto/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pull_request_dto.g.dart';

@JsonSerializable()
class PullRequestDto {
  const PullRequestDto({
    required this.id,
    required this.number,
    required this.title,
    required this.body,
    required this.state,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.htmlUrl,
    required this.draft,
  });

  factory PullRequestDto.fromJson(Map<String, dynamic> json) =>
      _$PullRequestDtoFromJson(json);

  final int id;
  final int number;
  final String title;
  final String? body;
  final String state;
  final UserDto? user;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  @JsonKey(name: 'html_url')
  final String htmlUrl;
  final bool draft;

  Map<String, dynamic> toJson() => _$PullRequestDtoToJson(this);
}
