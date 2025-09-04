import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:github_poc/domain/model/issue.dart';
import 'package:github_poc/domain/model/previewable.dart';
import 'package:github_poc/domain/model/pull_request.dart';
import 'package:github_poc/domain/model/repository.dart';
import 'package:github_poc/l10n/l10n.dart';
import 'package:intl/intl.dart';

class PreviewableListRouteParams {
  PreviewableListRouteParams({
    required this.repository,
    required this.items,
    required this.title,
  });
  final Repository repository;
  final List<Previewable> items;
  final String title;
}

@RoutePage()
class PreviewableListPage extends StatelessWidget {
  const PreviewableListPage({
    required this.parameters,
    super.key,
  });

  final PreviewableListRouteParams parameters;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(parameters.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Repository info header
            _RepositoryHeader(repository: parameters.repository),
            const SizedBox(height: 16),

            // Items count
            Text(
              '${parameters.items.length} ${parameters.title.toLowerCase()}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Items list
            Expanded(
              child: parameters.items.isEmpty
                  ? _EmptyState(type: parameters.title.toLowerCase())
                  : ListView.builder(
                      itemCount: parameters.items.length,
                      itemBuilder: (context, index) {
                        final item = parameters.items[index];
                        return _PreviewableCard(item: item);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RepositoryHeader extends StatelessWidget {
  const _RepositoryHeader({required this.repository});

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            repository.name,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            repository.fullName,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            l10n.noItemsFound(type),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewableCard extends StatelessWidget {
  const _PreviewableCard({required this.item});

  final Previewable item;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and state
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    item.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _StateChip(state: item.state, item: item),
              ],
            ),
            const SizedBox(height: 8),

            // Subtitle/Description
            if (item.subtitle.isNotEmpty)
              Text(
                item.subtitle,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            const SizedBox(height: 12),

            // Author and date info
            Row(
              children: [
                Text(
                  l10n.createdBy(item.author),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const Spacer(),
                Text(
                  l10n.updatedOn(DateFormat.yMMMd().format(item.updatedAt)),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Item-specific information
            _ItemSpecificInfo(item: item),
          ],
        ),
      ),
    );
  }
}

class _StateChip extends StatelessWidget {
  const _StateChip({required this.state, required this.item});

  final String state;
  final Previewable item;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    Color chipColor;
    String stateText;
    IconData icon;

    // Determine chip appearance based on state and item type
    switch (state.toLowerCase()) {
      case 'open':
        chipColor = Colors.green;
        stateText = l10n.open;
        icon = item is Issue ? Icons.error_outline : Icons.merge_type;
      case 'closed':
        chipColor = Colors.red;
        stateText = l10n.closed;
        icon = item is Issue ? Icons.check_circle_outline : Icons.close;
      case 'merged':
        chipColor = Colors.purple;
        stateText = l10n.merged;
        icon = Icons.merge;
      case 'draft':
        chipColor = Colors.grey;
        stateText = l10n.draft;
        icon = Icons.edit_outlined;
      default:
        chipColor = Colors.grey;
        stateText = state;
        icon = Icons.help_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: chipColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: chipColor,
          ),
          const SizedBox(width: 4),
          Text(
            stateText,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: chipColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemSpecificInfo extends StatelessWidget {
  const _ItemSpecificInfo({required this.item});

  final Previewable item;

  @override
  Widget build(BuildContext context) {
    if (item is Issue) {
      final issue = item as Issue;
      return _IssueSpecificInfo(issue: issue);
    } else if (item is PullRequest) {
      final pr = item as PullRequest;
      return _PullRequestSpecificInfo(pr: pr);
    }

    return const SizedBox.shrink();
  }
}

class _IssueSpecificInfo extends StatelessWidget {
  const _IssueSpecificInfo({required this.issue});

  final Issue issue;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Labels
        if (issue.labels.isNotEmpty)
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: issue.labels.map((label) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              );
            }).toList(),
          ),
        if (issue.labels.isNotEmpty) const SizedBox(height: 8),

        // Comments count
        Row(
          children: [
            Icon(
              Icons.comment_outlined,
              size: 16,
              color: Colors.grey[600],
            ),
            const SizedBox(width: 4),
            Text(
              '${issue.commentsCount} ${l10n.comments.toLowerCase()}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PullRequestSpecificInfo extends StatelessWidget {
  const _PullRequestSpecificInfo({required this.pr});

  final PullRequest pr;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Branch info
        Row(
          children: [
            Icon(
              Icons.call_split,
              size: 16,
              color: Colors.grey[600],
            ),
            const SizedBox(width: 4),
            Text(
              '${pr.sourceBranch} → ${pr.targetBranch}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Stats row
        Row(
          children: [
            // Reviews
            Icon(
              Icons.rate_review_outlined,
              size: 16,
              color: Colors.grey[600],
            ),
            const SizedBox(width: 4),
            Text(
              '${pr.reviewsCount} ${l10n.reviews.toLowerCase()}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(width: 16),

            // Changed files
            Icon(
              Icons.description_outlined,
              size: 16,
              color: Colors.grey[600],
            ),
            const SizedBox(width: 4),
            Text(
              '${pr.changedFiles} ${l10n.files.toLowerCase()}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(width: 16),

            // Additions/Deletions
            Text(
              '+${pr.additions}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '-${pr.deletions}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
