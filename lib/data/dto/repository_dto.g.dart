// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepositoryDto _$RepositoryDtoFromJson(Map<String, dynamic> json) =>
    RepositoryDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      fullName: json['full_name'] as String,
      description: json['description'] as String?,
      stargazersCount: (json['stargazers_count'] as num).toInt(),
      forksCount: (json['forks_count'] as num).toInt(),
      language: json['language'] as String?,
      htmlUrl: json['html_url'] as String,
      updatedAt: json['updated_at'] as String,
      owner: UserDto.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RepositoryDtoToJson(RepositoryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'full_name': instance.fullName,
      'description': instance.description,
      'stargazers_count': instance.stargazersCount,
      'forks_count': instance.forksCount,
      'language': instance.language,
      'html_url': instance.htmlUrl,
      'updated_at': instance.updatedAt,
      'owner': instance.owner,
    };
