import 'package:json_annotation/json_annotation.dart';

part 'issue_dto.g.dart';

@JsonSerializable()
class IssueDto {
  const IssueDto({
    required this.id,
    required this.number,
    required this.title,
    required this.body,
    required this.state,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.htmlUrl,
    required this.labels,
    required this.comments,
    required this.assignees,
  });

  factory IssueDto.fromJson(Map<String, dynamic> json) =>
      _$IssueDtoFromJson(json);

  final int id;
  final int number;
  final String title;
  final String? body;
  final String state;
  final UserDto user;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  @JsonKey(name: 'html_url')
  final String htmlUrl;
  final List<LabelDto> labels;
  final int comments;
  final List<UserDto> assignees;

  Map<String, dynamic> toJson() => _$IssueDtoToJson(this);
}

@JsonSerializable()
class UserDto {
  const UserDto({
    required this.id,
    required this.login,
    required this.avatarUrl,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  final int id;
  final String login;
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}

@JsonSerializable()
class LabelDto {
  const LabelDto({
    required this.id,
    required this.name,
    required this.color,
    required this.description,
  });

  factory LabelDto.fromJson(Map<String, dynamic> json) =>
      _$LabelDtoFromJson(json);

  final int id;
  final String name;
  final String color;
  final String? description;

  Map<String, dynamic> toJson() => _$LabelDtoToJson(this);
}
