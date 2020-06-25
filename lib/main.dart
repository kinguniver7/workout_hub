import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_hub/common/constants.dart';
import 'package:workout_hub/common/route_generator.dart';
import 'package:workout_hub/common/theme.dart';
import 'package:workout_hub/providers/common_provider.dart';
import 'package:workout_hub/providers/workouts_provider.dart';

void main() => runApp(
  EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ru'), Locale('uk')],
      path: 'assets/translations', 
      fallbackLocale: Locale('en'),
      child: MultiProvider(    
        providers: [
            ChangeNotifierProvider(create: (_) => CommonProvider()),
            ChangeNotifierProvider(create: (_) => WorkoutsProvider())
        ],
      child:MyApp()
  )
    ),
  
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      initialRoute: Constants.ROOUTE_NAME_TO_INIT_PAGE,
      debugShowCheckedModeBanner: false,
      title: 'title_app'.tr(),
      theme: appTheme(),
      //home: HomePage(),
      onGenerateRoute:  (RouteSettings settings) {return RouteGenerator.generateRoute(settings);},
    );
  }
}
