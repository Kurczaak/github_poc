// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [CounterPage]
class CounterRoute extends PageRouteInfo<void> {
  const CounterRoute({List<PageRouteInfo>? children})
    : super(CounterRoute.name, initialChildren: children);

  static const String name = 'CounterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CounterPage();
    },
  );
}

/// generated route for
/// [RepositoryDetailsPage]
class RepositoryDetailsRoute extends PageRouteInfo<RepositoryDetailsRouteArgs> {
  RepositoryDetailsRoute({
    required Repository repository,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         RepositoryDetailsRoute.name,
         args: RepositoryDetailsRouteArgs(repository: repository, key: key),
         initialChildren: children,
       );

  static const String name = 'RepositoryDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RepositoryDetailsRouteArgs>();
      return RepositoryDetailsPage(repository: args.repository, key: args.key);
    },
  );
}

class RepositoryDetailsRouteArgs {
  const RepositoryDetailsRouteArgs({required this.repository, this.key});

  final Repository repository;

  final Key? key;

  @override
  String toString() {
    return 'RepositoryDetailsRouteArgs{repository: $repository, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RepositoryDetailsRouteArgs) return false;
    return repository == other.repository && key == other.key;
  }

  @override
  int get hashCode => repository.hashCode ^ key.hashCode;
}

/// generated route for
/// [RepositorySearchPage]
class RepositorySearchRoute extends PageRouteInfo<void> {
  const RepositorySearchRoute({List<PageRouteInfo>? children})
    : super(RepositorySearchRoute.name, initialChildren: children);

  static const String name = 'RepositorySearchRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RepositorySearchPage();
    },
  );
}
