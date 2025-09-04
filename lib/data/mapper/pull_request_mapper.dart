import 'package:github_poc/data/dto/pull_request_dto.dart';
import 'package:github_poc/domain/model/pull_request.dart';

extension PullRequestDtoMapper on PullRequestDto {
  PullRequest toDomain() {
    return PullRequest(
      id: id,
      title: title,
      subtitle: body ?? '',
      author: user?.login ?? 'Unknown',
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
      state: state,
      url: htmlUrl,
      targetBranch: 'main', // Default since we removed branch info
      sourceBranch: 'feature', // Default since we removed branch info
      reviewsCount: 0, // Default since we removed detailed info
      isDraft: draft,
      changedFiles: 0, // Default since we removed detailed info
      additions: 0, // Default since we removed detailed info
      deletions: 0, // Default since we removed detailed info
    );
  }
}

extension PullRequestDtoListMapper on List<PullRequestDto> {
  List<PullRequest> toDomain() {
    return map((dto) => dto.toDomain()).toList();
  }
}
