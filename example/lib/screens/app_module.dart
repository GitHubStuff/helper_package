import 'package:example/screens/clock_screen.dart';
import 'package:example/screens/popover_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:helper_package/helper_package.dart';

import 'home_scaffold.dart';

class AppModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [
    //
  ];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const HomeScaffold()),
    ChildRoute(PopoverScreen.route, child: (_, __) => const PopoverScreen()),
    ChildRoute(ClockScreen.route, child: (_, __) => const ClockScreen()),
    ChildRoute(PictureScreen.route, child: (_, __) => const PictureScreen()),
  ];
}
