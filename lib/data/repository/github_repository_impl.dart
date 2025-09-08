import 'package:github_poc/data/client/github_api_client.dart';
import 'package:github_poc/data/mapper/issue_mapper.dart';
import 'package:github_poc/data/mapper/pull_request_mapper.dart';
import 'package:github_poc/data/mapper/repository_mapper.dart';
import 'package:github_poc/domain/model/issue.dart';
import 'package:github_poc/domain/model/pull_request.dart';
import 'package:github_poc/domain/model/repository.dart';
import 'package:github_poc/domain/repository/github_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GithubRepository, env: [Environment.prod, Environment.dev])
class GithubRepositoryImpl implements GithubRepository {
  const GithubRepositoryImpl(this._apiClient);

  final GithubApiClient _apiClient;

  @override
  Future<List<Repository>> searchRepositories(String query) async {
    try {
      final response = await _apiClient.searchRepositories(
        query,
        'stars', // Sort by stars
        'desc', // Descending order
        10, // Per page
        1, // Page number
      );
      return response.items.toDomain();
    } catch (e) {
      throw Exception('Failed to search repositories: $e');
    }
  }

  @override
  Future<List<Issue>> getRepositoryIssues(String owner, String repo) async {
    try {
      final issues = await _apiClient.getRepositoryIssues(
        owner,
        repo,
        'all', // State: all, open, closed
        'created', // Sort by creation date
        'desc', // Descending order
        30, // Per page
        1, // Page number
      );

      return issues.toDomain();
    } catch (e) {
      throw Exception('Failed to get repository issues: $e');
    }
  }

  @override
  Future<List<PullRequest>> getRepositoryPullRequests(
    String owner,
    String repo,
  ) async {
    try {
      final pullRequests = await _apiClient.getRepositoryPullRequests(
        owner,
        repo,
        'all', // State: all, open, closed
        'created', // Sort by creation date
        'desc', // Descending order
        30, // Per page
        1, // Page number
      );

      return pullRequests.toDomain();
    } catch (e) {
      throw Exception('Failed to get repository pull requests: $e');
    }
  }
}
