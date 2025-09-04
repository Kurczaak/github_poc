// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pull_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PullRequestDto _$PullRequestDtoFromJson(Map<String, dynamic> json) =>
    PullRequestDto(
      id: (json['id'] as num).toInt(),
      number: (json['number'] as num).toInt(),
      title: json['title'] as String,
      body: json['body'] as String?,
      state: json['state'] as String,
      user: json['user'] == null
          ? null
          : UserDto.fromJson(json['user'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      htmlUrl: json['html_url'] as String,
      draft: json['draft'] as bool,
    );

Map<String, dynamic> _$PullRequestDtoToJson(PullRequestDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'title': instance.title,
      'body': instance.body,
      'state': instance.state,
      'user': instance.user,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'html_url': instance.htmlUrl,
      'draft': instance.draft,
    };
