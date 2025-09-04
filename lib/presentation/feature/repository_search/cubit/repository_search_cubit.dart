import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_poc/domain/model/repository.dart';

part 'repository_search_state.dart';

class RepositorySearchCubit extends Cubit<RepositorySearchState> {
  RepositorySearchCubit() : super(const RepositorySearchInitial());

  void searchRepositories(String query) {
    if (query.isEmpty) {
      emit(const RepositorySearchInitial());
      return;
    }

    emit(const RepositorySearchLoading());

    // Simulate some processing time
    Future.delayed(const Duration(milliseconds: 500), () {
      // Mock search results for now
      final repositories = _generateMockRepositories(query);
      emit(RepositorySearchSuccess(repositories: repositories, query: query));
    });
  }

  void clearSearch() {
    emit(const RepositorySearchInitial());
  }

  List<Repository> _generateMockRepositories(String query) {
    // Generate mock repositories based on search query
    return List.generate(5, (index) {
      return Repository(
        id: index + 1,
        name: '${query.toLowerCase()}-repo-${index + 1}',
        fullName: 'user/${query.toLowerCase()}-repo-${index + 1}',
        description:
            'A mock repository for $query with some interesting features and capabilities.',
        stargazersCount: (index + 1) * 150,
        forksCount: (index + 1) * 25,
        language: ['Dart', 'TypeScript', 'Python', 'JavaScript', 'Go'][index],
        htmlUrl:
            'https://github.com/user/${query.toLowerCase()}-repo-${index + 1}',
        updatedAt: DateTime.now().subtract(Duration(days: index + 1)),
      );
    });
  }
}
