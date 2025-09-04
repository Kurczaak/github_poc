import 'package:github_poc/domain/model/issue.dart';
import 'package:github_poc/domain/repository/github_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRepositoryIssuesUseCase {
  const GetRepositoryIssuesUseCase(this._githubRepository);

  final GithubRepository _githubRepository;

  Future<List<Issue>> call(String owner, String repo) async {
    if (owner.trim().isEmpty) {
      throw ArgumentError('Owner cannot be empty');
    }
    if (repo.trim().isEmpty) {
      throw ArgumentError('Repository name cannot be empty');
    }

    return _githubRepository.getRepositoryIssues(owner.trim(), repo.trim());
  }
}
