import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';

final String fontFamily = 'Roboto';
final String fontFamilyThin = 'RobotoThin';
final String fontFamilyLight = 'RobotoLight';
final String fontFamilyMedium = 'RobotoMedium';

///***** Abstract Theme *****/
///abstract theme that all theme impl should extend
abstract class AbstractTheme {
  Color appBarBorder();
  Color bottomBarBorder();
  Color iconInkWell();

  double devicePixelRatio;
  double aspectRatio;
  double deviceHeight;
  double deviceWidth;
  Size size;
  String androidOriOS;
  String model;
  Color textColor;
  //Color errorColor;

  _deviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    bool isAndroid = false;
    try {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      androidOriOS = 'android';
      model = androidInfo.model;
      isAndroid = true;
    } catch (e) {} //intentionally consuming}
    if (!isAndroid) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      androidOriOS = 'iOS';
      model = iosInfo.utsname.machine;
    }
  }

  ThemeData getTheme() {
    return ThemeData(brightness: Brightness.light, fontFamily: fontFamily, errorColor: Colors.red);
  }

  void mediaQueryData(MediaQueryData mqd) {
    this.devicePixelRatio = mqd.devicePixelRatio;
    this.aspectRatio = mqd.size.aspectRatio;
    this.deviceWidth = mqd.size.width;
    this.deviceHeight = mqd.size.height;
    this.size = mqd.size;

    //_printDeviceInfo();
  }

  void _printDeviceInfo() async {
    await _deviceInfo();
    debugPrint("***************");
    debugPrint('androidOriOS: {$androidOriOS}');
    debugPrint('model: {$model}');
    debugPrint('devicePixelRatio: {$devicePixelRatio}');
    debugPrint('aspectRatio: {$aspectRatio}');
    debugPrint('deviceWidth: {$deviceWidth}');
    debugPrint('deviceHeight: {$deviceHeight}');
    debugPrint("***************");
  }
}

///***** Theme Inherited Widget *****/
class ThemeProvider extends InheritedWidget {
  final AbstractTheme currentTheme;

  const ThemeProvider({this.currentTheme, Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(ThemeProvider old) {
    return this.currentTheme != old.currentTheme;
  }

  static ThemeProvider of(BuildContext context) => context.inheritFromWidgetOfExactType(ThemeProvider);
}

///***** Contemporary Theme *****/
///First concrete impl of AbstractTheme
///note: common impl should be moved from ContemporaryTheme to AbstractTheme
class ContemporaryTheme extends AbstractTheme {
  final Color textColor = Colors.grey[600];
  final Color backgroundColor = Color(0xFFffffff);

  @override
  Color appBarBorder() {
    return Colors.grey[300];
  }

  @override
  Color bottomBarBorder() {
    return Colors.grey[300];
  }

  @override
  Color iconInkWell() {
    return Colors.black54;
  }

  @override
  ThemeData getTheme() {
    return super.getTheme().copyWith(
        //primary color
        primaryColor: const Color(0xFFffffff),
        primaryColorLight: const Color(0xFFffffff),
        primaryColorDark: const Color(0xFFffffff),
        //accent color
        accentColor: Colors.grey[300],
        //all containers and child widgets inherit this color by default
        scaffoldBackgroundColor: backgroundColor,
        //text theme (primary and accent)
        textTheme: this._textTheme(),
        //app bar theme
        appBarTheme: this._appBarTheme(),
        backgroundColor: const Color(0xFFffffff),

        //buttonTheme: ButtonThemeData(colorScheme: ColorScheme(background: Colors.yellow)),
        //used for border color eg: Container
        dividerColor: Colors.grey[400]);
  }

  AppBarTheme _appBarTheme() {
    return AppBarTheme(
      iconTheme: IconThemeData(color: textColor),
      elevation: 0,
      textTheme: _textTheme(),
    );
  }

  TextTheme _textTheme() {
    return TextTheme(
      display4: TextStyle(fontSize: 96, fontFamily: fontFamilyLight, letterSpacing: -1.5, color: textColor),
      display3: TextStyle(fontSize: 60, fontFamily: fontFamilyLight, letterSpacing: -0.5, color: textColor),
      display2: TextStyle(fontSize: 48, fontFamily: fontFamily, letterSpacing: 0.0, color: textColor),
      display1: TextStyle(fontSize: 34, fontFamily: fontFamily, letterSpacing: 0.25, color: textColor),
      headline: TextStyle(fontSize: 24, fontFamily: fontFamily, letterSpacing: 0.0, color: textColor),
      title: TextStyle(fontSize: 16, fontFamily: fontFamily, letterSpacing: -0.15, color: textColor),
      subhead: TextStyle(fontSize: 16, fontFamily: fontFamily, letterSpacing: 0.15, color: textColor),
      body2: TextStyle(fontSize: 16, fontFamily: fontFamily, letterSpacing: 0.5, color: textColor),
      body1: TextStyle(fontSize: 14, fontFamily: fontFamily, letterSpacing: 0.25, color: textColor),
      caption: TextStyle(fontSize: 12, fontFamily: fontFamily, letterSpacing: 0.4, color: textColor),
      button: TextStyle(fontSize: 14, fontFamily: fontFamilyMedium, letterSpacing: 0.75, color: textColor),
      subtitle: TextStyle(fontSize: 14, fontFamily: fontFamilyMedium, letterSpacing: 0.1, color: textColor),
      overline: TextStyle(fontSize: 10, fontFamily: fontFamily, letterSpacing: 1.5, color: textColor),
    );
  }
}
