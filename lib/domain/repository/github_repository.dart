import 'package:github_poc/domain/model/issue.dart';
import 'package:github_poc/domain/model/pull_request.dart';
import 'package:github_poc/domain/model/repository.dart';

abstract class GithubRepository {
  /// Search for repositories based on a query string
  Future<List<Repository>> searchRepositories(String query);

  /// Get issues for a specific repository
  Future<List<Issue>> getRepositoryIssues(String repositoryId);

  /// Get pull requests for a specific repository
  Future<List<PullRequest>> getRepositoryPullRequests(String repositoryId);
}
