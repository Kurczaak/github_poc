import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_poc/domain/model/repository.dart';
import 'package:github_poc/domain/use_case/search_for_repositories_use_case.dart';
import 'package:injectable/injectable.dart';

part 'repository_search_state.dart';

@injectable
class RepositorySearchCubit extends Cubit<RepositorySearchState> {
  RepositorySearchCubit(this._searchForRepositoriesUseCase)
    : super(const RepositorySearchInitial());

  final SearchForRepositoriesUseCase _searchForRepositoriesUseCase;

  Future<void> searchRepositories(String query) async {
    if (query.isEmpty) {
      emit(const RepositorySearchInitial());
      return;
    }

    emit(const RepositorySearchLoading());

    try {
      final repositories = await _searchForRepositoriesUseCase(query);
      emit(RepositorySearchSuccess(repositories: repositories, query: query));
    } catch (error) {
      emit(RepositorySearchError(message: error.toString()));
    }
  }

  void clearSearch() {
    emit(const RepositorySearchInitial());
  }
}
