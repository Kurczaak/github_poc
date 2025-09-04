import 'package:github_poc/domain/model/pull_request.dart';
import 'package:github_poc/domain/repository/github_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRepositoryPullRequestUseCase {
  const GetRepositoryPullRequestUseCase(this._githubRepository);

  final GithubRepository _githubRepository;

  Future<List<PullRequest>> call(String repositoryId) async {
    if (repositoryId.trim().isEmpty) {
      throw ArgumentError('Repository ID cannot be empty');
    }

    return _githubRepository.getRepositoryPullRequests(repositoryId.trim());
  }
}
