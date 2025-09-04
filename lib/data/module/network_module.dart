import 'package:dio/dio.dart';
import 'package:github_poc/data/client/github_api_client.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @LazySingleton()
  Dio provideDio() {
    final dio = Dio();

    // Add logging interceptor
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        logPrint: print,
      ),
    );

    // Set default headers
    const githubToken = String.fromEnvironment('GITHUB_TOKEN');
    dio.options.headers.addAll({
      'Accept': 'application/vnd.github.v3+json',
      'User-Agent': 'GitHub-POC-Flutter-App',
      if (githubToken.isNotEmpty) 'Authorization': 'Bearer $githubToken',
    });

    // Set timeouts
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);

    return dio;
  }

  @LazySingleton()
  GithubApiClient provideGithubApiClient(Dio dio) {
    return GithubApiClient(dio);
  }
}
