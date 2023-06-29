import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:helper_package/helper_package.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'screens/app_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Palette.setup();

  runApp(ProviderScope(
    child: ModularApp(
      module: AppModule(),
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setNavigatorKey(Global.navigatorKey);
    return MaterialApp.router(
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      title: 'Flutter Demo',
      //locale: Language.locale,
      theme: null,
      darkTheme: null,
      themeMode: null,
      localizationsDelegates: const [],
    );
  }
}
