// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueDto _$IssueDtoFromJson(Map<String, dynamic> json) => IssueDto(
  id: (json['id'] as num).toInt(),
  number: (json['number'] as num).toInt(),
  title: json['title'] as String,
  body: json['body'] as String?,
  state: json['state'] as String,
  user: UserDto.fromJson(json['user'] as Map<String, dynamic>),
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
  htmlUrl: json['html_url'] as String,
  labels: (json['labels'] as List<dynamic>)
      .map((e) => LabelDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  comments: (json['comments'] as num).toInt(),
  assignees: (json['assignees'] as List<dynamic>)
      .map((e) => UserDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$IssueDtoToJson(IssueDto instance) => <String, dynamic>{
  'id': instance.id,
  'number': instance.number,
  'title': instance.title,
  'body': instance.body,
  'state': instance.state,
  'user': instance.user,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'html_url': instance.htmlUrl,
  'labels': instance.labels,
  'comments': instance.comments,
  'assignees': instance.assignees,
};

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
  id: (json['id'] as num).toInt(),
  login: json['login'] as String,
  avatarUrl: json['avatar_url'] as String,
);

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
  'id': instance.id,
  'login': instance.login,
  'avatar_url': instance.avatarUrl,
};

LabelDto _$LabelDtoFromJson(Map<String, dynamic> json) => LabelDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  color: json['color'] as String,
  description: json['description'] as String?,
);

Map<String, dynamic> _$LabelDtoToJson(LabelDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'color': instance.color,
  'description': instance.description,
};
