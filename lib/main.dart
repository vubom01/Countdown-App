import 'package:flutter/material.dart';

import 'runner/global_config.dart';
import 'src/my_app.dart';

void main() async {
  const String environment = String.fromEnvironment('environment');
  switch (environment) {
    case 'dev':
      await GlobalConfig.initApp(env: '.env');
      break;
    case 'prod':
      await GlobalConfig.initApp(env: '.env.prod');
      break;
    default:
      await GlobalConfig.initApp(env: '.env');
  }

  runApp(const MyApp());
}
