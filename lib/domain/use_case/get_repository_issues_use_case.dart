import 'package:github_poc/domain/model/issue.dart';
import 'package:github_poc/domain/repository/github_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRepositoryIssuesUseCase {
  const GetRepositoryIssuesUseCase(this._githubRepository);

  final GithubRepository _githubRepository;

  Future<List<Issue>> call(String repositoryId) async {
    if (repositoryId.trim().isEmpty) {
      throw ArgumentError('Repository ID cannot be empty');
    }

    return _githubRepository.getRepositoryIssues(repositoryId.trim());
  }
}
