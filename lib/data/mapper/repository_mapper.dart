import 'package:github_poc/data/dto/repository_dto.dart';
import 'package:github_poc/data/mapper/user_mapper.dart';
import 'package:github_poc/domain/model/repository.dart';

extension RepositoryDtoMapper on RepositoryDto {
  Repository toDomain() {
    return Repository(
      id: id,
      name: name,
      fullName: fullName,
      description: description ?? '',
      stargazersCount: stargazersCount,
      forksCount: forksCount,
      language: language ?? 'Unknown',
      htmlUrl: htmlUrl,
      updatedAt: DateTime.parse(updatedAt),
      owner: owner.toDomainModel(),
    );
  }
}

extension RepositoryDtoListMapper on List<RepositoryDto> {
  List<Repository> toDomain() {
    return map((dto) => dto.toDomain()).toList();
  }
}
