import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  const UserDto({
    required this.id,
    required this.login,
    required this.avatarUrl,
    required this.htmlUrl,
    required this.type,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  final int id;
  final String login;
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;
  @JsonKey(name: 'html_url')
  final String htmlUrl;
  final String type;

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
