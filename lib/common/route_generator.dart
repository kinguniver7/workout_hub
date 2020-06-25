import 'package:flutter/material.dart';
import 'package:workout_hub/common/constants.dart';
import 'package:workout_hub/model/params/workout_lits_params.dart';
import 'package:workout_hub/model/params/workout_params.dart';
import 'package:workout_hub/pages/home_page.dart';
import 'package:workout_hub/pages/reminder_page.dart';
import 'package:workout_hub/pages/report_page.dart';
import 'package:workout_hub/pages/settings_page.dart';
import 'package:workout_hub/pages/workout/finish_page.dart';
import 'package:workout_hub/pages/workout/workout_list_page.dart';
import 'package:workout_hub/pages/workout/workout_page.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings) {      
    return MaterialPageRoute(
      builder: (context) => switchRoute(settings)
    );
  }
  static Widget switchRoute(RouteSettings settings) {
    switch (settings.name) {
      case Constants.ROOUTE_NAME_TO_REMINDER_PAGE:
        return ReminderPage();
       case Constants.ROOUTE_NAME_TO_SETTINGS_PAGE:
        return SettingsPage();
      case Constants.ROOUTE_NAME_TO_REPORT_PAGE:
        return ReportPage();
      case Constants.ROOUTE_NAME_TO_WORKOUT_LIST_PAGE:
        if(settings.arguments != null){
          final WorkoutListParams params = settings.arguments as WorkoutListParams;
          if(params != null){
            return WorkoutListPage(params);            
          }
        }
        //TODO:Need to add log
        return HomePage();
      case Constants.ROOUTE_NAME_TO_WORKOUT_PAGE:
        if(settings.arguments != null){
          final WorkoutParams params = settings.arguments as WorkoutParams;
          if(params != null){
            return WorkoutPage(params);            
          }
        }
        //TODO:Need to add log
        return HomePage();
      case Constants.ROOUTE_NAME_TO_FINISH_PAGE:
        return FinishPage();
        /* if(settings.arguments != null){
          final WorkoutParams params = settings.arguments as WorkoutParams;
          if(params != null){
            return WorkoutPage(params);            
          }
        } */
        //TODO:Need to add log
        //return HomePage();
      case Constants.ROOUTE_NAME_TO_INIT_PAGE:       
      default:
        return HomePage(); 
    }
  }

}