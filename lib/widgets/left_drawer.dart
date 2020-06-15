import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_hub/common/constants.dart';
import 'package:workout_hub/providers/common_provider.dart';
import 'package:easy_localization/easy_localization.dart';

class LeftDrawer extends StatefulWidget {
  @override
  _LeftDrawerState createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName:  Text(''),
            accountEmail: Text('')            
          ),
          Consumer<CommonProvider>(
            builder: (context, model, _){
              return ListTile(
                leading: Icon(Icons.fitness_center),
                title: Text('home_page.title').tr(),
                selected: model.selectedRouteName == Constants.ROOUTE_NAME_TO_INIT_PAGE,
                onTap: () { 
                  Navigator.pushNamedAndRemoveUntil(context, Constants.ROOUTE_NAME_TO_INIT_PAGE,(Route<dynamic> route) => false);
                  model.selectedRouteName = Constants.ROOUTE_NAME_TO_INIT_PAGE;                                  
                },
              );
            },
          ),
          Consumer<CommonProvider>(
            builder: (context, model, _){
              return ListTile(
                leading: Icon(Icons.show_chart),
                title: Text('report_page.title').tr(),
                selected: model.selectedRouteName == Constants.ROOUTE_NAME_TO_REPORT_PAGE,
                onTap: () { 
                  Navigator.pushNamedAndRemoveUntil(context, Constants.ROOUTE_NAME_TO_REPORT_PAGE,(Route<dynamic> route) => false);  
                  model.selectedRouteName = Constants.ROOUTE_NAME_TO_REPORT_PAGE;                                
                },
              );
            },
          ),
          Consumer<CommonProvider>(
            builder: (context, model, _){
              return ListTile(
                leading: Icon(Icons.alarm_on),
                title: Text('reminder_page.title').tr(),
                selected: model.selectedRouteName == Constants.ROOUTE_NAME_TO_REMINDER_PAGE,
                onTap: () { 
                  Navigator.pushNamedAndRemoveUntil(context, Constants.ROOUTE_NAME_TO_REMINDER_PAGE,(Route<dynamic> route) => false);
                  model.selectedRouteName = Constants.ROOUTE_NAME_TO_REMINDER_PAGE;                                  
                },
              );
            },
          ),
         
          Divider(),
          Consumer<CommonProvider>(
            builder: (context, model, _){
              return ListTile(
                leading: Icon(Icons.settings),
                title: Text('settings_page.title').tr(),
                selected: model.selectedRouteName == Constants.ROOUTE_NAME_TO_SETTINGS_PAGE,
                onTap: () { 
                  Navigator.pushNamedAndRemoveUntil(context, Constants.ROOUTE_NAME_TO_SETTINGS_PAGE,(Route<dynamic> route) => false);
                  model.selectedRouteName = Constants.ROOUTE_NAME_TO_SETTINGS_PAGE;                                  
                },
              );
            },
          ),
        ],
      )
    );
  
  }
}