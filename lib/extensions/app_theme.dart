import 'package:sport/extensions/imports.dart';

extension ThemeExt on ThemeData {
  bool get isLight => true;
  bool get isDark => false;

  Color get cNavActiveIconColor => const Color(0xFFdf036c);
  Color get cNavInActiveIconColor => const Color(0xFF797979);
  Color get cNavBgColor => const Color(0xFFf0f0f0);
  Color get cAppBGColor => const Color(0xFFFFFFFF);

  Color get onlyWhite => Colors.white;
  Color get onlyGrey => Colors.grey;
  Color get onlyBlack => Colors.black;
  Color get transparent => Colors.transparent;
  Color get grayBorderColor => const Color(0xFFe7e7e7);
  Color get btnColor => const Color(0xFFfa0c74);
  Color get checkoutImgCover => const Color(0xFFd5d5e9);

  Color get lightGray => const Color(0xFFF1F1F1);

  String get kJosefinSansBold => 'Helvetica_Caps';

  // Fonts
  TextStyle get textBold => TextStyle(
        fontFamily: 'JosefinSansBold',
        fontSize: 14.w,
      );
  TextStyle get textMedium => TextStyle(
        fontFamily: 'JosefinSansMedium',
        fontSize: 14.w,
      );
  TextStyle get textRegular => TextStyle(
        fontFamily: 'JosefinSansMedium',
        fontSize: 14.w,
      );
}
