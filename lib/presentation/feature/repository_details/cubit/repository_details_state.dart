part of 'repository_details_cubit.dart';

abstract class RepositoryDetailsState extends Equatable {
  const RepositoryDetailsState();

  @override
  List<Object?> get props => [];
}

class RepositoryDetailsInitial extends RepositoryDetailsState {
  const RepositoryDetailsInitial();
}

class RepositoryDetailsLoading extends RepositoryDetailsState {
  const RepositoryDetailsLoading();
}

class RepositoryDetailsSuccess extends RepositoryDetailsState {
  const RepositoryDetailsSuccess({
    required this.issues,
    required this.openPullRequests,
    required this.totalPullRequests,
  });

  final List<Issue> issues;
  final List<PullRequest> openPullRequests;
  final int totalPullRequests;

  @override
  List<Object?> get props => [issues, openPullRequests, totalPullRequests];
}

class RepositoryDetailsError extends RepositoryDetailsState {
  const RepositoryDetailsError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
