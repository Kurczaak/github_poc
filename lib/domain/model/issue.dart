import 'package:github_poc/domain/model/previewable.dart';

class Issue extends Previewable {
  const Issue({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.author,
    required super.createdAt,
    required super.updatedAt,
    required super.state,
    required super.url,
    required this.labels,
    required this.commentsCount,
    required this.assignees,
  });

  final List<String> labels;
  final int commentsCount;
  final List<String> assignees;

  @override
  List<Object?> get props => [
    ...super.props,
    labels,
    commentsCount,
    assignees,
  ];
}
