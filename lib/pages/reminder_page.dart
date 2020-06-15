import 'package:flutter/material.dart';
import 'package:workout_hub/widgets/left_drawer.dart';
import 'package:easy_localization/easy_localization.dart';

class ReminderPage extends StatefulWidget {
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LeftDrawer(),
      appBar: AppBar(title: Text("reminder_page.title").tr(),),
      body: Center(
        child: Text("Test"),
      )
    );
  }
}