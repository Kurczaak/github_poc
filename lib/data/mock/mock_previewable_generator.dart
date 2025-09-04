import 'package:github_poc/domain/model/issue.dart';
import 'package:github_poc/domain/model/previewable.dart';
import 'package:github_poc/domain/model/pull_request.dart';
import 'package:github_poc/domain/model/repository.dart';

class MockPreviewableGenerator {
  static List<Previewable> generateMockIssues(Repository repository) {
    return [
      Issue(
        id: 1,
        title: 'Fix authentication bug in login flow',
        subtitle:
            'Users are unable to login with valid credentials. Error occurs during token validation.',
        author: 'john_doe',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
        state: 'open',
        url: '${repository.htmlUrl}/issues/1',
        labels: const ['bug', 'authentication', 'high-priority'],
        commentsCount: 8,
        assignees: const ['jane_smith', 'bob_wilson'],
      ),
      Issue(
        id: 2,
        title: 'Add dark mode support',
        subtitle:
            'Implement dark theme across the entire application with user preference storage.',
        author: 'design_team',
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
        state: 'open',
        url: '${repository.htmlUrl}/issues/2',
        labels: const ['enhancement', 'ui', 'theme'],
        commentsCount: 15,
        assignees: const ['alice_cooper'],
      ),
      Issue(
        id: 3,
        title: 'Update dependencies to latest versions',
        subtitle:
            'Several dependencies are outdated and need to be updated for security reasons.',
        author: 'security_team',
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        updatedAt: DateTime.now().subtract(const Duration(days: 10)),
        state: 'closed',
        url: '${repository.htmlUrl}/issues/3',
        labels: const ['maintenance', 'dependencies', 'security'],
        commentsCount: 3,
        assignees: const ['john_doe'],
      ),
      Issue(
        id: 4,
        title: 'Performance optimization for large datasets',
        subtitle:
            'Application becomes slow when handling large amounts of data. Need to optimize queries.',
        author: 'backend_team',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 6)),
        state: 'open',
        url: '${repository.htmlUrl}/issues/4',
        labels: const ['performance', 'backend', 'optimization'],
        commentsCount: 12,
        assignees: const ['performance_specialist'],
      ),
    ];
  }

  static List<Previewable> generateMockPullRequests(Repository repository) {
    return [
      PullRequest(
        id: 101,
        title: 'Implement user profile page with avatar upload',
        subtitle:
            'Add new user profile page allowing users to upload and manage their profile pictures.',
        author: 'frontend_dev',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
        state: 'open',
        url: '${repository.htmlUrl}/pull/101',
        targetBranch: 'main',
        sourceBranch: 'feature/user-profile',
        reviewsCount: 2,
        isDraft: false,
        changedFiles: 8,
        additions: 245,
        deletions: 12,
      ),
      PullRequest(
        id: 102,
        title: 'Fix memory leak in image processing',
        subtitle:
            'Resolve memory leak that occurs when processing large images in the background.',
        author: 'mobile_dev',
        createdAt: DateTime.now().subtract(const Duration(days: 4)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 3)),
        state: 'open',
        url: '${repository.htmlUrl}/pull/102',
        targetBranch: 'main',
        sourceBranch: 'bugfix/memory-leak',
        reviewsCount: 1,
        isDraft: false,
        changedFiles: 3,
        additions: 89,
        deletions: 156,
      ),
      PullRequest(
        id: 103,
        title: 'Add comprehensive unit tests for auth module',
        subtitle:
            'Increase test coverage for authentication module from 60% to 95%.',
        author: 'qa_engineer',
        createdAt: DateTime.now().subtract(const Duration(days: 6)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
        state: 'merged',
        url: '${repository.htmlUrl}/pull/103',
        targetBranch: 'main',
        sourceBranch: 'test/auth-coverage',
        reviewsCount: 3,
        isDraft: false,
        changedFiles: 12,
        additions: 456,
        deletions: 23,
      ),
      PullRequest(
        id: 104,
        title: 'WIP: Refactor database connection pooling',
        subtitle:
            'Work in progress: Implementing new connection pooling strategy for better performance.',
        author: 'database_admin',
        createdAt: DateTime.now().subtract(const Duration(hours: 8)),
        updatedAt: DateTime.now().subtract(const Duration(minutes: 30)),
        state: 'draft',
        url: '${repository.htmlUrl}/pull/104',
        targetBranch: 'develop',
        sourceBranch: 'feature/db-pooling',
        reviewsCount: 0,
        isDraft: true,
        changedFiles: 6,
        additions: 178,
        deletions: 89,
      ),
      PullRequest(
        id: 105,
        title: 'Update CI/CD pipeline configuration',
        subtitle:
            'Modernize build pipeline and add automated deployment to staging environment.',
        author: 'devops_team',
        createdAt: DateTime.now().subtract(const Duration(days: 8)),
        updatedAt: DateTime.now().subtract(const Duration(days: 8)),
        state: 'closed',
        url: '${repository.htmlUrl}/pull/105',
        targetBranch: 'main',
        sourceBranch: 'devops/pipeline-update',
        reviewsCount: 4,
        isDraft: false,
        changedFiles: 15,
        additions: 334,
        deletions: 267,
      ),
    ];
  }
}
