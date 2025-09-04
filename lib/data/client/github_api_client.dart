import 'package:dio/dio.dart';
import 'package:github_poc/data/dto/issue_dto.dart';
import 'package:github_poc/data/dto/pull_request_dto.dart';
import 'package:github_poc/data/dto/search_repositories_response_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'github_api_client.g.dart';

@RestApi(baseUrl: 'https://api.github.com')
abstract class GithubApiClient {
  factory GithubApiClient(Dio dio, {String baseUrl}) = _GithubApiClient;

  @GET('/search/repositories')
  Future<SearchRepositoriesResponseDto> searchRepositories(
    @Query('q') String query,
    @Query('sort') String sort,
    @Query('order') String order,
    @Query('per_page') int perPage,
    @Query('page') int page,
  );

  @GET('/repos/{owner}/{repo}/issues')
  Future<List<IssueDto>> getRepositoryIssues(
    @Path('owner') String owner,
    @Path('repo') String repo,
    @Query('state') String state,
    @Query('sort') String sort,
    @Query('direction') String direction,
    @Query('per_page') int perPage,
    @Query('page') int page,
  );

  @GET('/repos/{owner}/{repo}/pulls')
  Future<List<PullRequestDto>> getRepositoryPullRequests(
    @Path('owner') String owner,
    @Path('repo') String repo,
    @Query('state') String state,
    @Query('sort') String sort,
    @Query('direction') String direction,
    @Query('per_page') int perPage,
    @Query('page') int page,
  );
}
