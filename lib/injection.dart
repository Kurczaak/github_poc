import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:github_poc/injection.config.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() {
  const flavor = appFlavor ?? 'test';
  late String environment;
  if (flavor.startsWith('prod')) {
    environment = Environment.prod;
  } else if (flavor.startsWith('dev')) {
    environment = Environment.dev;
  } else {
    environment = Environment.test;
  }

  getIt.init(
    environment: environment,
  );
}
