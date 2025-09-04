import 'package:github_poc/domain/model/previewable.dart';

class PullRequest extends Previewable {
  const PullRequest({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.author,
    required super.createdAt,
    required super.updatedAt,
    required super.state,
    required super.url,
    required this.targetBranch,
    required this.sourceBranch,
    required this.reviewsCount,
    required this.isDraft,
    required this.changedFiles,
    required this.additions,
    required this.deletions,
  });

  final String targetBranch;
  final String sourceBranch;
  final int reviewsCount;
  final bool isDraft;
  final int changedFiles;
  final int additions;
  final int deletions;

  @override
  List<Object?> get props => [
    ...super.props,
    targetBranch,
    sourceBranch,
    reviewsCount,
    isDraft,
    changedFiles,
    additions,
    deletions,
  ];
}
