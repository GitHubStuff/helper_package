import 'package:example/screens/clock_screen.dart';
import 'package:example/screens/popover_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_scaffold.dart';

class AppModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  void binds(i) {}

  // Provide all the routes for your module
  @override
  void routes(r) {
    r.child('/', child: (_) => const HomeScaffold());
    r.child(PopoverScreen.route, child: (_) => const PopoverScreen());
    r.child(ClockScreen.route, child: (_) => const ClockScreen());
  }
}
