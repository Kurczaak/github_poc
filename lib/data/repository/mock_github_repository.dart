import 'package:github_poc/domain/model/issue.dart';
import 'package:github_poc/domain/model/pull_request.dart';
import 'package:github_poc/domain/model/repository.dart';
import 'package:github_poc/domain/repository/github_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: GithubRepository)
class MockGithubRepository implements GithubRepository {
  @override
  Future<List<Repository>> searchRepositories(String query) async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 800));

    // Generate mock repositories based on search query
    return List.generate(5, (index) {
      return Repository(
        id: index + 1,
        name: '${query.toLowerCase()}-repo-${index + 1}',
        fullName: 'user/${query.toLowerCase()}-repo-${index + 1}',
        description:
            'A mock repository for $query with some interesting features and capabilities.',
        stargazersCount: (index + 1) * 150,
        forksCount: (index + 1) * 25,
        language: ['Dart', 'TypeScript', 'Python', 'JavaScript', 'Go'][index],
        htmlUrl:
            'https://github.com/user/${query.toLowerCase()}-repo-${index + 1}',
        updatedAt: DateTime.now().subtract(Duration(days: index + 1)),
      );
    });
  }

  @override
  Future<List<Issue>> getRepositoryIssues(String id) async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 600));

    // Extract owner and name from repositoryId (format: "owner/name")
    final parts = id.split('/');
    final owner = parts.isNotEmpty ? parts[0] : 'unknown';
    final name = parts.length > 1 ? parts[1] : 'repo';

    return List.generate(8, (index) {
      return Issue(
        id: index + 1,
        title:
            'Issue ${index + 1}: Fix the ${_getRandomFeature(index)} functionality',
        subtitle:
            'This is a detailed description of issue ${index + 1}. '
            'We need to fix the ${_getRandomFeature(index)} functionality because '
            "it's causing problems for users.",
        author: 'user${(index % 3) + 1}',
        createdAt: DateTime.now().subtract(Duration(days: index + 1)),
        updatedAt: DateTime.now().subtract(Duration(hours: index * 2)),
        state: index % 3 == 0 ? 'closed' : 'open',
        url: 'https://github.com/$owner/$name/issues/${index + 100}',
        labels: _getRandomLabels(index),
        commentsCount: (index + 1) * 2,
        assignees: index % 2 == 0 ? ['user${index + 1}'] : [],
      );
    });
  }

  @override
  Future<List<PullRequest>> getRepositoryPullRequests(
    String repositoryId,
  ) async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 700));

    // Extract owner and name from repositoryId (format: "owner/name")
    final parts = repositoryId.split('/');
    final owner = parts.isNotEmpty ? parts[0] : 'unknown';
    final name = parts.length > 1 ? parts[1] : 'repo';

    return List.generate(6, (index) {
      return PullRequest(
        id: index + 1,
        title: 'PR ${index + 1}: Implement ${_getRandomFeature(index)} feature',
        subtitle:
            'This pull request implements the ${_getRandomFeature(index)} feature. '
            'It includes proper testing and documentation.',
        author: 'contributor${(index % 4) + 1}',
        createdAt: DateTime.now().subtract(Duration(days: index + 2)),
        updatedAt: DateTime.now().subtract(Duration(hours: index * 3)),
        state: index % 4 == 0 ? 'closed' : 'open',
        url: 'https://github.com/$owner/$name/pull/${index + 200}',
        targetBranch: 'main',
        sourceBranch: 'feature/${_getRandomFeature(index)}',
        reviewsCount: (index % 3) + 1,
        isDraft: index % 5 == 0,
        changedFiles: (index + 1) * 3,
        additions: (index + 1) * 50,
        deletions: (index + 1) * 10,
      );
    });
  }

  String _getRandomFeature(int index) {
    final features = [
      'authentication',
      'user profile',
      'search',
      'notifications',
      'settings',
      'dashboard',
      'repository',
      'comments',
    ];
    return features[index % features.length];
  }

  List<String> _getRandomLabels(int index) {
    final allLabels = [
      'bug',
      'enhancement',
      'documentation',
      'help wanted',
      'good first issue',
    ];
    final labelCount = (index % 3) + 1;
    return allLabels.take(labelCount).toList();
  }
}
