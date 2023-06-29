import 'dart:ffi' hide Size;

import 'package:flutter/material.dart';

//* Default is to have 8pts between widgets
const EdgeInsetsGeometry _paddingBetweenWidgets = EdgeInsets.only(right: 8.0);

extension BuildContextExtensions<T> on BuildContext {
  bool get isKeyBoardOpen => mediaQuery.viewInsets.bottom > 0;
  Brightness get platformBrightness => mediaQuery.platformBrightness;
  ColorScheme get colorScheme => appTheme.colorScheme;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  TextTheme get primaryTextTheme => appTheme.primaryTextTheme;
  TextTheme get textTheme => appTheme.textTheme;
  ThemeData get appTheme => Theme.of(this);
  List<Locale>? get locales => findAncestorWidgetOfExactType<MaterialApp>()?.supportedLocales.toList();

  void hideKeyboard() => !FocusScope.of(this).hasPrimaryFocus ? FocusScope.of(this).unfocus() : Void;

  bool get isMobile => MediaQuery.of(this).size.width <= 500.0;

  bool get isTablet => MediaQuery.of(this).size.width < 1024.0 && MediaQuery.of(this).size.width >= 650.0;

  bool get isSmallTablet => MediaQuery.of(this).size.width < 650.0 && MediaQuery.of(this).size.width > 500.0;

  bool get isDesktop => MediaQuery.of(this).size.width >= 1024.0;

  bool get isSmall => MediaQuery.of(this).size.width < 850.0 && MediaQuery.of(this).size.width >= 560.0;

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  Size get size => MediaQuery.of(this).size;

  /// Set appbar title to String, Widget, [Widgets], Image, AssetImage, TextStyle
  ///
  /// NOTE: can do [TextStyle, string,...], and the text style will be applied to all the following strings
  ///
  /// Example:
  ///  AppBar(title: context.appBarWidget('JUST String')); ~ Text('JUST TEXT');
  ///
  ///  AppBar(title: context.appBarWidget(Text('Just Widget')));
  ///
  ///  * Adding a TextStyle will set/reset for all the following widgets {execept the next TextStyle of course}
  ///  AppBar(title: context.appBarWidgets('Title', TextStyle(fontStyle.bold), 'Bolded'))
  ///
  ///  AppBar(title: context.appBarWidgets(Image(...), AssetImage(...)));
  ///
  Row appBarWidgets(dynamic stuff, {EdgeInsetsGeometry? padding, double appBarHeight = 32.0}) {
    assert(stuff != null);
    assert(appBarHeight >= 0.0);
    List<dynamic> items = (stuff is List) ? stuff : [stuff];
    final List<Widget> result = [];
    final EdgeInsetsGeometry itemPadding = padding ?? _paddingBetweenWidgets;
    TextStyle? textStyle;
    for (dynamic item in items) {
      if (item is Image) {
        final resizedImage = Image(
          image: item.image,
          height: appBarHeight,
          fit: BoxFit.fitHeight,
        );
        result.add(Padding(padding: itemPadding, child: resizedImage));
        continue;
      }
      if (item is AssetImage) {
        result.add(Padding(
          padding: itemPadding,
          child: Image(
            image: item,
            height: appBarHeight,
            width: appBarHeight,
            fit: BoxFit.fitHeight,
          ),
        ));
        continue;
      }
      if (item is TextStyle) {
        textStyle = item;
        continue;
      }
      if (item is String) {
        result.add(Padding(
          padding: itemPadding,
          child: Text(item, style: textStyle),
        ));
        continue;
      }
      assert(item is Widget);
      result.add(item);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: result,
    );
  }

  // text styles

  TextStyle? get displayMedium => Theme.of(this).textTheme.displayMedium;

  TextStyle? get displaySmall => Theme.of(this).textTheme.displaySmall;

  TextStyle? get headlineLarge => Theme.of(this).textTheme.headlineLarge;

  TextStyle? get headlineMedium => Theme.of(this).textTheme.headlineMedium;

  TextStyle? get titleLarge => Theme.of(this).textTheme.titleLarge;

  TextStyle? get titleMedium => Theme.of(this).textTheme.titleMedium;

  TextStyle? get titleSmall => Theme.of(this).textTheme.titleSmall;

  TextStyle? get labelLarge => Theme.of(this).textTheme.labelLarge;

  TextStyle? get bodySmall => Theme.of(this).textTheme.bodySmall;

  TextStyle? get titleTextStyle => Theme.of(this).appBarTheme.titleTextStyle;

  TextStyle? get bodyExtraSmall => bodySmall?.copyWith(fontSize: 10, height: 1.6, letterSpacing: .5);

  TextStyle? get bodyLarge => Theme.of(this).textTheme.bodyLarge;

  TextStyle? get dividerTextSmall => bodySmall?.copyWith(
        letterSpacing: 0.5,
        fontWeight: FontWeight.w700,
        fontSize: 12.0,
      );

  TextStyle? get dividerTextLarge => bodySmall?.copyWith(
        letterSpacing: 1.5,
        fontWeight: FontWeight.w700,
        fontSize: 13.0,
        height: 1.23,
      );

  // colors

  Color get primaryColor => Theme.of(this).primaryColor;

  Color get primaryColorDark => Theme.of(this).primaryColorDark;

  Color get primaryColorLight => Theme.of(this).primaryColorLight;

  Color get primary => Theme.of(this).colorScheme.primary;

  Color get onPrimary => Theme.of(this).colorScheme.onPrimary;

  Color get secondary => Theme.of(this).colorScheme.secondary;

  Color get onSecondary => Theme.of(this).colorScheme.onSecondary;

  Color get cardColor => Theme.of(this).cardColor;

  Color get errorColor => Theme.of(this).colorScheme.error;

  Color get background => Theme.of(this).colorScheme.background;

  Future<T?> showBottomSheet(
    Widget child, {
    bool isScrollControlled = true,
    Color? backgroundColor,
    Color? barrierColor,
  }) {
    return showModalBottomSheet(
      context: this,
      barrierColor: barrierColor,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      builder: (context) => Wrap(children: [child]),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(String message) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
