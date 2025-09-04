import 'package:github_poc/domain/model/repository.dart';
import 'package:github_poc/domain/repository/github_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchForRepositoriesUseCase {
  const SearchForRepositoriesUseCase(this._githubRepository);

  final GithubRepository _githubRepository;

  Future<List<Repository>> call(String query) async {
    if (query.trim().isEmpty) {
      throw ArgumentError('Query cannot be empty');
    }

    return _githubRepository.searchRepositories(query.trim());
  }
}
