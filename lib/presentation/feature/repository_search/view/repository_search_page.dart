import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_poc/app/router/app_router.dart';
import 'package:github_poc/domain/model/repository.dart';
import 'package:github_poc/l10n/l10n.dart';
import 'package:github_poc/presentation/feature/repository_search/cubit/repository_search_cubit.dart';

@RoutePage()
class RepositorySearchPage extends StatelessWidget {
  const RepositorySearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RepositorySearchCubit(),
      child: const RepositorySearchView(),
    );
  }
}

class RepositorySearchView extends StatefulWidget {
  const RepositorySearchView({super.key});

  @override
  State<RepositorySearchView> createState() => _RepositorySearchViewState();
}

class _RepositorySearchViewState extends State<RepositorySearchView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.repositorySearchTitle),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search Input
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: l10n.searchRepositoriesHint,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    context.read<RepositorySearchCubit>().clearSearch();
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (query) {
                if (query.isNotEmpty) {
                  context.read<RepositorySearchCubit>().searchRepositories(
                    query,
                  );
                }
              },
            ),
            const SizedBox(height: 16),

            // Search Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final query = _searchController.text.trim();
                  if (query.isNotEmpty) {
                    context.read<RepositorySearchCubit>().searchRepositories(
                      query,
                    );
                  }
                },
                child: Text(l10n.searchButton),
              ),
            ),
            const SizedBox(height: 24),

            // Results
            Expanded(
              child: BlocBuilder<RepositorySearchCubit, RepositorySearchState>(
                builder: (context, state) {
                  if (state is RepositorySearchInitial) {
                    return const _EmptyState();
                  } else if (state is RepositorySearchLoading) {
                    return const _LoadingState();
                  } else if (state is RepositorySearchSuccess) {
                    return _SuccessState(state: state);
                  } else if (state is RepositorySearchError) {
                    return _ErrorState(state: state);
                  } else {
                    return const _EmptyState();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            l10n.searchForGitHubRepositories,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.enterKeywordsToFind,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(l10n.searchingRepositories),
        ],
      ),
    );
  }
}

class _SuccessState extends StatelessWidget {
  const _SuccessState({required this.state});

  final RepositorySearchSuccess state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.foundRepositoriesFor(state.repositories.length, state.query),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: state.repositories.length,
            itemBuilder: (context, index) {
              final repo = state.repositories[index];
              return _RepositoryCard(
                repository: repo,
                onTap: () {
                  context.router.push(
                    RepositoryDetailsRoute(repository: repo),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.state});

  final RepositorySearchError state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red[400],
          ),
          const SizedBox(height: 16),
          Text(
            l10n.error,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.red[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            state.message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.red[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _RepositoryCard extends StatelessWidget {
  const _RepositoryCard({
    required this.repository,
    this.onTap,
  });

  final Repository repository;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Repository name and full name
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
              const SizedBox(height: 8),

              // Description
              if (repository.description.isNotEmpty)
                Text(
                  repository.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              const SizedBox(height: 12),

              // Stats and language
              Row(
                children: [
                  // Language
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      repository.language,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  const Spacer(),

                  // Stars
                  Icon(
                    Icons.star,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    repository.stargazersCount.toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 16),

                  // Forks
                  Icon(
                    Icons.call_split,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    repository.forksCount.toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
