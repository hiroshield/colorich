import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool backup = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 30.0,
            fontFamily: "KleeOne",
            fontWeight: FontWeight.w600,
          ),
        ),
        gradient: const LinearGradient(
          colors: [
            Colors.blueAccent,
            Colors.cyanAccent,
          ],
        ),
      ),
      body: SettingsList(
        contentPadding: const EdgeInsets.all(9.0),
        sections: [
          SettingsSection(
            title: 'BACKUP',
            titleTextStyle: const TextStyle(
              fontSize: 20,
            ),
            tiles: [
              SettingsTile.switchTile(
                title: 'iCloud',
                titleTextStyle: const TextStyle(fontSize: 18),
                leading: Icon(
                  backup == false ? Icons.cloud_off : Icons.cloud_done_outlined,
                  size: 30,
                ),
                switchValue: backup,
                onToggle: (bool value) {
                  setState(() {
                    if (backup == false) {
                      backup = true;
                    } else {
                      backup = false;
                    }
                  });
                },
              ),
            ],
          ),
          //AndroidでのGoogle One 同期はこの中に書く
          SettingsSection(
            title: 'ACTIONS',
            titleTextStyle: const TextStyle(
              fontSize: 20,
            ),
            tiles: const [
              SettingsTile(
                title: 'Message',
                titleTextStyle: TextStyle(fontSize: 18),
                leading: Icon(Icons.mail_outline_outlined, size: 30),
              ),
              SettingsTile(
                title: 'Review',
                titleTextStyle: TextStyle(fontSize: 18),
                leading: Icon(FontAwesomeIcons.appStore, size: 30),
              ),
              //Androidの場合は、GooglePlayへ遷移
              SettingsTile(
                title: 'Instagram',
                titleTextStyle: TextStyle(fontSize: 18),
                leading: Icon(FontAwesomeIcons.instagram, size: 30),
              ),
            ],
          ),
          SettingsSection(
            title: 'INFORMATION',
            titleTextStyle: const TextStyle(
              fontSize: 20,
            ),
            tiles: const [
              SettingsTile(
                title: 'Version 1.0.0',
                titleTextStyle: TextStyle(fontSize: 18),
                leading: Icon(Icons.info_outline_rounded, size: 30),
                trailing: Text(''),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
