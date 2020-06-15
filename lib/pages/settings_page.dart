import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:workout_hub/widgets/left_drawer.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LeftDrawer(),
      appBar: AppBar(title: Text("settings_page.title").tr(),),
      body: Container(
        child: SettingsList(
        sections: [
          SettingsSection(
            title: 'Section',
            tiles: [
              SettingsTile(
                title: 'Language',
                subtitle: 'English',
                leading: Icon(Icons.language),
                onTap: () {},
              ),
              SettingsTile.switchTile(
                title: 'Use fingerprint',
                leading: Icon(Icons.fingerprint),
                switchValue: true,
                onToggle: (bool value) {},
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }
}