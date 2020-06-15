import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:workout_hub/widgets/left_drawer.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LeftDrawer(),
      appBar: AppBar(title: Text('report_page.title').tr(),),
    );
  }
}