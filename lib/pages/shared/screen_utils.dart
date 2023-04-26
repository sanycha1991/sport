import 'package:flutter/services.dart';

import 'package:sport/extensions/imports.dart';

class InitScreenUtils extends StatelessWidget {
  final Widget child;

  const InitScreenUtils({
    Key? key,
    required this.child,
  }) : super(key: key);

  void setOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void setStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light,
    );
  }

  @override
  Widget build(BuildContext context) {
    setOrientation();
    setStatusBarColor();
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, _) {
        return child;
      },
    );
  }
}
