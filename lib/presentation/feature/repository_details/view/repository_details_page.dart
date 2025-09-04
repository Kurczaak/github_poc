import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_poc/app/router/app_router.dart';
import 'package:github_poc/domain/model/repository.dart';
import 'package:github_poc/injection.dart';
import 'package:github_poc/l10n/l10n.dart';
import 'package:github_poc/presentation/feature/previewable_list/view/previewable_list_page.dart';
import 'package:github_poc/presentation/feature/repository_details/cubit/repository_details_cubit.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class RepositoryDetailsPage extends StatelessWidget {
  const RepositoryDetailsPage({
    required this.repository,
    super.key,
  });

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<RepositoryDetailsCubit>()..loadRepositoryData(repository),
      child: _RepositoryDetailsView(repository: repository),
    );
  }
}

class _RepositoryDetailsView extends StatelessWidget {
  const _RepositoryDetailsView({required this.repository});

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.repositoryDetails),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Repository Header
            _RepositoryHeader(repository: repository),
            const SizedBox(height: 24),

            // Description Section
            _DescriptionSection(repository: repository),
            const SizedBox(height: 24),

            // Statistics Section
            _StatisticsSection(repository: repository),
            const SizedBox(height: 24),

            // Issues and Pull Requests Navigation
            BlocBuilder<RepositoryDetailsCubit, RepositoryDetailsState>(
              builder: (context, state) {
                return _NavigationSection(
                  repository: repository,
                  state: state,
                );
              },
            ),
            const SizedBox(height: 24),

            // Last Updated
            _LastUpdatedSection(repository: repository),
            const SizedBox(height: 32),

            // GitHub Button
            _GitHubButton(repository: repository),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Owner information
        Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(repository.owner.avatarUrl),
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    repository.owner.login,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    repository.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  const _DescriptionSection({required this.repository});

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.description,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
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
          child: Text(
            repository.description.isNotEmpty
                ? repository.description
                : l10n.noDescriptionAvailable,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontStyle: repository.description.isEmpty
                  ? FontStyle.italic
                  : null,
              color: repository.description.isEmpty ? Colors.grey[600] : null,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatisticsSection extends StatelessWidget {
  const _StatisticsSection({required this.repository});

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.stats,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.star,
                label: l10n.stars,
                value: repository.stargazersCount.toString(),
                color: Colors.amber,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                icon: Icons.call_split,
                label: l10n.forks,
                value: repository.forksCount.toString(),
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                icon: Icons.code,
                label: l10n.language,
                value: repository.language,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _LastUpdatedSection extends StatelessWidget {
  const _LastUpdatedSection({required this.repository});

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final formattedDate = DateFormat.yMMMd().format(repository.updatedAt);

    return Row(
      children: [
        Icon(
          Icons.schedule,
          size: 20,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 8),
        Text(
          l10n.lastUpdated,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          formattedDate,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _GitHubButton extends StatelessWidget {
  const _GitHubButton({required this.repository});

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => _launchUrl(repository.htmlUrl),
        icon: const Icon(Icons.open_in_new),
        label: Text(l10n.viewOnGitHub),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _NavigationSection extends StatelessWidget {
  const _NavigationSection({
    required this.repository,
    required this.state,
  });

  final Repository repository;
  final RepositoryDetailsState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Browse',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        if (state is RepositoryDetailsLoading) ...[
          Row(
            children: [
              Expanded(
                child: _LoadingNavigationCard(
                  icon: Icons.error_outline,
                  label: l10n.issues,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _LoadingNavigationCard(
                  icon: Icons.merge_type,
                  label: l10n.pullRequests,
                ),
              ),
            ],
          ),
        ] else if (state is RepositoryDetailsSuccess) ...[
          Row(
            children: [
              Expanded(
                child: _NavigationCard(
                  icon: Icons.error_outline,
                  label: l10n.issues,
                  count: (state as RepositoryDetailsSuccess).issues.length,
                  onTap: () {
                    context.router.push(
                      PreviewableListRoute(
                        parameters: PreviewableListRouteParams(
                          repository: repository,
                          items: (state as RepositoryDetailsSuccess).issues,
                          title: l10n.issues,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _NavigationCard(
                  icon: Icons.merge_type,
                  label: l10n.pullRequests,
                  count: (state as RepositoryDetailsSuccess)
                      .openPullRequests
                      .length,
                  onTap: () {
                    context.router.push(
                      PreviewableListRoute(
                        parameters: PreviewableListRouteParams(
                          repository: repository,
                          items: (state as RepositoryDetailsSuccess)
                              .openPullRequests,
                          title: l10n.pullRequests,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ] else if (state is RepositoryDetailsError) ...[
          Row(
            children: [
              Expanded(
                child: _ErrorNavigationCard(
                  icon: Icons.error_outline,
                  label: l10n.issues,
                  onRetry: () =>
                      context.read<RepositoryDetailsCubit>().retry(repository),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ErrorNavigationCard(
                  icon: Icons.merge_type,
                  label: l10n.pullRequests,
                  onRetry: () =>
                      context.read<RepositoryDetailsCubit>().retry(repository),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _NavigationCard extends StatelessWidget {
  const _NavigationCard({
    required this.icon,
    required this.label,
    required this.onTap,
    this.count,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final int? count;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 8),
            if (count != null) ...[
              Text(
                count.toString(),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 4),
            ],
            Text(
              label,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingNavigationCard extends StatelessWidget {
  const _LoadingNavigationCard({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 32,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ErrorNavigationCard extends StatelessWidget {
  const _ErrorNavigationCard({
    required this.icon,
    required this.label,
    required this.onRetry,
  });

  final IconData icon;
  final String label;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onRetry,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.error.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.error.withOpacity(0.05),
        ),
        child: Column(
          children: [
            Icon(
              Icons.refresh,
              size: 32,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 8),
            Text(
              'Retry',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
