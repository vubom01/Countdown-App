enum Flavor {
  dev,
  stage,
  prod,
}

class FlavorMode {
  const FlavorMode({
    required this.flavor,
    required this.baseUrl,
    this.services = const {},
  });

  final Flavor flavor;
  final String baseUrl;
  final Map<String, String> services;
}

class AppMode {
  AppMode._privateConstructor();

  static final AppMode _instance = AppMode._privateConstructor();

  factory AppMode() => _instance;

  FlavorMode _appMode = const FlavorMode(
    flavor: Flavor.dev,
    baseUrl: '',
    services: {},
  );

  FlavorMode get appMode => _appMode;

  void setAppMode(FlavorMode value) => _appMode = value;
}
