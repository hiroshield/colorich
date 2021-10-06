import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool backup = false;
  final urlApp = 'https://apps.apple.com';
  final urlIns = 'https://www.instagram.com/hiroshu_diary';

  Future<void> _launchURL(openURL) async {
    var url = openURL;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Unable to launch url $url';
    }
  }

  void _openMailApp() async {
    final title = Uri.encodeComponent('');
    final body = Uri.encodeComponent('');
    const mailAddress = 'hiroshu.diary@mail.com';

    return _launchURL("mailto:$mailAddress?subject=$title&body=$body");
  }

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
            titleTextStyle: const TextStyle(fontSize: 20),
            tiles: [
              SettingsTile(
                onPressed: (BuildContext context) => _openMailApp,
                title: 'Message',
                titleTextStyle: const TextStyle(fontSize: 18),
                leading: const Icon(Icons.mail_outline_outlined, size: 30),
              ),
              SettingsTile(
                onPressed: (BuildContext context) => _launchURL(urlApp),
                title: 'Review',
                titleTextStyle: const TextStyle(fontSize: 18),
                leading: const Icon(FontAwesomeIcons.appStore, size: 30),
              ),
              //Androidの場合は、GooglePlayへ遷移
              SettingsTile(
                onPressed: (BuildContext context) => _launchURL(urlIns),
                title: 'Instagram',
                titleTextStyle: const TextStyle(fontSize: 18),
                leading: const Icon(FontAwesomeIcons.instagram, size: 30),
              ),
            ],
          ),
          SettingsSection(
            title: 'INFORMATION',
            titleTextStyle: const TextStyle(fontSize: 20),
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
