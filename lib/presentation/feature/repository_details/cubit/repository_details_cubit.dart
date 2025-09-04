import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_poc/domain/model/issue.dart';
import 'package:github_poc/domain/model/pull_request.dart';
import 'package:github_poc/domain/model/repository.dart';
import 'package:github_poc/domain/use_case/get_repository_issues_use_case.dart';
import 'package:github_poc/domain/use_case/get_repository_pull_request_use_case.dart';
import 'package:injectable/injectable.dart';

part 'repository_details_state.dart';

@injectable
class RepositoryDetailsCubit extends Cubit<RepositoryDetailsState> {
  RepositoryDetailsCubit(
    this._getRepositoryIssuesUseCase,
    this._getRepositoryPullRequestUseCase,
  ) : super(const RepositoryDetailsInitial());

  final GetRepositoryIssuesUseCase _getRepositoryIssuesUseCase;
  final GetRepositoryPullRequestUseCase _getRepositoryPullRequestUseCase;

  Future<void> loadRepositoryData(Repository repository) async {
    emit(const RepositoryDetailsLoading());

    try {
      // Load both issues and pull requests in parallel
      final results = await Future.wait([
        _getRepositoryIssuesUseCase(repository.fullName),
        _getRepositoryPullRequestUseCase(repository.fullName),
      ]);

      final issues = results[0] as List<Issue>;
      final pullRequests = results[1] as List<PullRequest>;

      // Filter for open pull requests
      final openPullRequests = pullRequests
          .where((pr) => pr.state == 'open')
          .toList();

      emit(
        RepositoryDetailsSuccess(
          issues: issues,
          openPullRequests: openPullRequests,
          totalPullRequests: pullRequests.length,
        ),
      );
    } catch (error) {
      emit(RepositoryDetailsError(message: error.toString()));
    }
  }

  void retry(Repository repository) {
    loadRepositoryData(repository);
  }
}
