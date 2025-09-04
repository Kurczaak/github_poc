import 'package:github_poc/data/dto/issue_dto.dart';
import 'package:github_poc/domain/model/issue.dart';

extension IssueDtoMapper on IssueDto {
  Issue toDomain() {
    return Issue(
      id: id,
      title: title,
      subtitle: body ?? '',
      author: user.login,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
      state: state,
      url: htmlUrl,
      labels: labels.map((label) => label.name).toList(),
      commentsCount: comments,
      assignees: assignees.map((assignee) => assignee.login).toList(),
    );
  }
}

extension IssueDtoListMapper on List<IssueDto> {
  List<Issue> toDomain() {
    return map((dto) => dto.toDomain()).toList();
  }
}
