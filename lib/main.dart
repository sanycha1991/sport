import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sport/extensions/config.dart';
import 'package:sport/extensions/localization.dart';
import 'package:sport/pages/shared/screen_utils.dart';
import 'package:sport/pages/shared/wrapper.dart';
import 'package:sport/services/checkout/checkout_provider.dart';
import 'package:sport/services/products/products_cubit.dart';
import 'package:sport/services/products/products_repository.dart';
import 'extensions/imports.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProductsCubit(repository: ProductsRepository()),
        ),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CheckoutProvider()),
        ],
        child: InitScreenUtils(
          child: MaterialApp(
            title: 'Sports ecommerce',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: LanguageConfig.supportedLocales,
            locale: LanguageConfig.defaultLocale,
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              // primarySwatch: Colors.blue,
              splashColor: Colors.transparent,
              scaffoldBackgroundColor: context.theme.cAppBGColor,
            ),
            home: const Wrapper(),
            // home: const MyHomePage(title: 'Test'),
          ),
        ),
      ),
    );
  }
}
