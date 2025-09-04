// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:github_poc/data/repository/mock_github_repository.dart'
    as _i417;
import 'package:github_poc/domain/repository/github_repository.dart' as _i168;
import 'package:github_poc/domain/use_case/get_repository_issues_use_case.dart'
    as _i145;
import 'package:github_poc/domain/use_case/get_repository_pull_request_use_case.dart'
    as _i970;
import 'package:github_poc/domain/use_case/search_for_repositories_use_case.dart'
    as _i595;
import 'package:github_poc/presentation/feature/previewable_list/cubit/previewable_list_cubit.dart'
    as _i905;
import 'package:github_poc/presentation/feature/repository_details/cubit/repository_details_cubit.dart'
    as _i814;
import 'package:github_poc/presentation/feature/repository_search/cubit/repository_search_cubit.dart'
    as _i543;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i168.GithubRepository>(
      () => _i417.MockGithubRepository(),
    );
    gh.factory<_i595.SearchForRepositoriesUseCase>(
      () => _i595.SearchForRepositoriesUseCase(gh<_i168.GithubRepository>()),
    );
    gh.factory<_i970.GetRepositoryPullRequestUseCase>(
      () => _i970.GetRepositoryPullRequestUseCase(gh<_i168.GithubRepository>()),
    );
    gh.factory<_i145.GetRepositoryIssuesUseCase>(
      () => _i145.GetRepositoryIssuesUseCase(gh<_i168.GithubRepository>()),
    );
    gh.factory<_i543.RepositorySearchCubit>(
      () =>
          _i543.RepositorySearchCubit(gh<_i595.SearchForRepositoriesUseCase>()),
    );
    gh.factory<_i905.PreviewableListCubit>(
      () => _i905.PreviewableListCubit(
        gh<_i145.GetRepositoryIssuesUseCase>(),
        gh<_i970.GetRepositoryPullRequestUseCase>(),
      ),
    );
    gh.factory<_i814.RepositoryDetailsCubit>(
      () => _i814.RepositoryDetailsCubit(
        gh<_i145.GetRepositoryIssuesUseCase>(),
        gh<_i970.GetRepositoryPullRequestUseCase>(),
      ),
    );
    return this;
  }
}
