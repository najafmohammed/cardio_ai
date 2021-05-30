import 'package:cardio_ai/shared/ColorApp.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool notification=true;
  @override
  Widget build(BuildContext context) {
    return Column(

        children: [
      SettingsList(
        backgroundColor: darkCard,
        shrinkWrap: true,
        sections: [
          SettingsSection(
            title: 'General',
            tiles: [
              SettingsTile(
                title: 'Language',
                titleTextStyle: whitePopSmall,
                trailing: Text('English',style: whitePopSmall,),
                leading: Icon(Icons.language,color: Colors.white,),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                title: 'Notifications',
                titleTextStyle: whitePopSmall,
                leading: Icon(Icons.notifications,color: Colors.white,),
                switchValue: notification,
                onToggle: (bool value) {
                  print(value);
                  setState(() {
                    notification=!notification;
                  });
                },
              ),
            ],
          ),
        ],
      )
    ]);
  }
}
