part of 'repository_search_cubit.dart';

abstract class RepositorySearchState extends Equatable {
  const RepositorySearchState();

  @override
  List<Object?> get props => [];
}

class RepositorySearchInitial extends RepositorySearchState {
  const RepositorySearchInitial();
}

class RepositorySearchLoading extends RepositorySearchState {
  const RepositorySearchLoading();
}

class RepositorySearchSuccess extends RepositorySearchState {
  const RepositorySearchSuccess({
    required this.repositories,
    required this.query,
  });

  final List<Repository> repositories;
  final String query;

  @override
  List<Object?> get props => [repositories, query];
}

class RepositorySearchError extends RepositorySearchState {
  const RepositorySearchError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
