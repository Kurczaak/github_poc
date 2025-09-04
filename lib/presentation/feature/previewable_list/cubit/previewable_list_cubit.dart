import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_poc/domain/model/previewable.dart';
import 'package:github_poc/domain/use_case/get_repository_issues_use_case.dart';
import 'package:github_poc/domain/use_case/get_repository_pull_request_use_case.dart';
import 'package:injectable/injectable.dart';

part 'previewable_list_state.dart';

@injectable
class PreviewableListCubit extends Cubit<PreviewableListState> {
  PreviewableListCubit(
    this._getRepositoryIssuesUseCase,
    this._getRepositoryPullRequestUseCase,
  ) : super(const PreviewableListInitial());

  final GetRepositoryIssuesUseCase _getRepositoryIssuesUseCase;
  final GetRepositoryPullRequestUseCase _getRepositoryPullRequestUseCase;

  Future<void> loadIssues(String repoId) async {
    emit(const PreviewableListLoading());

    try {
      final issues = await _getRepositoryIssuesUseCase(repoId);
      emit(
        PreviewableListSuccess(
          items: issues.cast<Previewable>(),
          type: PreviewableType.issues,
        ),
      );
    } catch (error) {
      emit(PreviewableListError(message: error.toString()));
    }
  }

  Future<void> loadPullRequests(String repoId) async {
    emit(const PreviewableListLoading());

    try {
      final pullRequests = await _getRepositoryPullRequestUseCase(repoId);
      emit(
        PreviewableListSuccess(
          items: pullRequests.cast<Previewable>(),
          type: PreviewableType.pullRequests,
        ),
      );
    } catch (error) {
      emit(PreviewableListError(message: error.toString()));
    }
  }
}
