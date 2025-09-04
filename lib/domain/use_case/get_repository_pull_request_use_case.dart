import 'package:github_poc/domain/model/pull_request.dart';
import 'package:github_poc/domain/repository/github_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRepositoryPullRequestUseCase {
  const GetRepositoryPullRequestUseCase(this._githubRepository);

  final GithubRepository _githubRepository;

  Future<List<PullRequest>> call(String owner, String repo) async {
    if (owner.trim().isEmpty) {
      throw ArgumentError('Owner cannot be empty');
    }
    if (repo.trim().isEmpty) {
      throw ArgumentError('Repository name cannot be empty');
    }

    return _githubRepository.getRepositoryPullRequests(owner.trim(), repo.trim());
  }
}
