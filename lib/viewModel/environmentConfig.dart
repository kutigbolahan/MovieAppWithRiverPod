import 'package:flutter_riverpod/flutter_riverpod.dart';

final environmentConfigProvider = Provider<EnvironmentConfig>((ref) {
  return EnvironmentConfig();
});

class EnvironmentConfig {
  final movieApiKey = const String.fromEnvironment("movieApiKey");
}
