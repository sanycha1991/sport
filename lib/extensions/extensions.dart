import 'package:flutter/cupertino.dart';
import 'package:sport/extensions/imports.dart';
import 'dart:developer' as dev;

import 'package:sport/extensions/localization.dart';

extension StringExt on String {
  String get svg => 'assets/svg/$this.svg';
  String get png => 'assets/png/$this.png';
  String get jpg => 'assets/jpg/$this.jpg';
}

extension DoubleExt on double {
  String get usdFormat => '\$${this}';
}

extension BuildContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);

  double withOf(double prc) => MediaQuery.of(this).size.width / 100 * prc;
  double heightOf(double prc) => MediaQuery.of(this).size.height / 100 * prc;

  String trs(String value) => AppLocalizations.of(this)!.translate(value);

  NavigatorState get nav => Navigator.of(this);
  Future push(Widget page) {
    return nav.push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  void pop([res]) => nav.pop(res);
}

dd(dynamic v) {
  dev.log(v.toString());
}
