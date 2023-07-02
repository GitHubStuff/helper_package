import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:helper_package/helper_package.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'screens/app_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Palette.setup(); // <--- For persiting theme setting

  // <--- Modular : creates a global context variable Global.context
  Modular.setNavigatorKey(Global.navigatorKey);

  // <--- Riverpod
  runApp(ProviderScope(
    // <--- Modular
    child: ModularApp(
      module: AppModule(),
      child: const MyApp(),
    ),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(paletteProvider);
    return MaterialApp.router(
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      title: 'Flutter Demo',
      //locale: Language.locale,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: currentTheme,
      localizationsDelegates: const [],
    );
  }
}
