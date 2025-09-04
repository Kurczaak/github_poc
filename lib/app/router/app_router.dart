import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:github_poc/domain/model/repository.dart';
import 'package:github_poc/presentation/feature/counter/view/counter_page.dart';
import 'package:github_poc/presentation/feature/repository_details/view/repository_details_page.dart';
import 'package:github_poc/presentation/feature/repository_search/view/repository_search_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    // Home route - Repository Search
    AutoRoute(
      page: RepositorySearchRoute.page,
      
      path: '/',
      initial: true,
    ),
    // Repository Details
    AutoRoute(
      page: RepositoryDetailsRoute.page,
      path: '/repository-details',
    ),
    // Counter route
    AutoRoute(
      page: CounterRoute.page,
      path: '/counter',
    ),
  ];
}
