// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_repositories_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchRepositoriesResponseDto _$SearchRepositoriesResponseDtoFromJson(
  Map<String, dynamic> json,
) => SearchRepositoriesResponseDto(
  totalCount: (json['total_count'] as num).toInt(),
  incompleteResults: json['incomplete_results'] as bool,
  items: (json['items'] as List<dynamic>)
      .map((e) => RepositoryDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SearchRepositoriesResponseDtoToJson(
  SearchRepositoriesResponseDto instance,
) => <String, dynamic>{
  'total_count': instance.totalCount,
  'incomplete_results': instance.incompleteResults,
  'items': instance.items,
};
