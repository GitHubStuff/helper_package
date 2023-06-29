// ignore_for_file: empty_catches, nullable_type_in_catch_clause
/// AppTheme is used to persist the [Brightness] setting of the application.
/// This class uses [Hive] package to store/reload changes in brightness.

part of 'palette.dart';

const String _boxNameForTheme = 'hive.box.name.1e1e40e586614a6d9ed12b2693738663';

class _PaletteTheme {
  static Box? _box;
  static ThemeMode _mode = ThemeMode.system;

  static ThemeMode get mode => _mode;
  static set mode(ThemeMode newMode) {
    if (_box == null) throw TypeError();
    _mode = newMode;
    _box?.put(_boxNameForTheme, newMode.name);
  }

  static Future<void> setup() async {
    try {
      if (!kIsWeb && Platform.environment.containsKey('FLUTTER_TEST')) {
        var path = Directory.current.path;
        Hive.init(path);
      } else {
        await Hive.initFlutter();
      }
      _box = await Hive.openBox<String>(_boxNameForTheme);
      mode = _translate(fromString: _box!.get(_boxNameForTheme, defaultValue: ThemeMode.system.name));
    } on TypeError {
    } on MissingPluginException {
    } catch (e) {
      throw FlutterError(e.toString());
    }
  }

  static ThemeMode _translate({required String fromString}) => ThemeMode.values.firstWhere((element) => element.name == fromString);
}
