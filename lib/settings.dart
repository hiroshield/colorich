import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool backup = false;
  bool notification = false;
  final mailAddress = 'hiroshu.diary@mail.com';
  TimeOfDay _time = const TimeOfDay(hour: 21, minute: 00);
  final urlApp = 'https://apps.apple.com/jp/app/minimaru/id1577885243';
  final urlIns = 'https://www.instagram.com/hiroshu_diary';

  //URLを後で変える
  Future<void> notify() async {
    final flnp = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      return flnp
          .initialize(
            const InitializationSettings(
              iOS: IOSInitializationSettings(),
            ),
          )
          .then(
            (_) => flnp.showDailyAtTime(
              0,
              '',
              'Be ColoRich！',
              Time(_time.hour, _time.minute),
              const NotificationDetails(
                iOS: IOSNotificationDetails(),
              ),
            ),
          );
    } else if (Platform.isAndroid) {
      return flnp
          .initialize(
            const InitializationSettings(
              android: AndroidInitializationSettings('@mipmap/ic_launcher'),
            ),
          )
          .then(
            (_) => flnp.showDailyAtTime(
              0,
              '',
              'Be ColoRich！',
              Time(_time.hour, _time.minute),
              const NotificationDetails(
                android: AndroidNotificationDetails(
                  'channel_id',
                  'channel_name',
                  // 'channel_description',
                  importance: Importance.high,
                  priority: Priority.high,
                ),
              ),
            ),
          );
    }
  }

  Future<void> _launchURL(openURL) async {
    var url = openURL;
    if (Platform.isIOS) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Unable to launch url $url';
      }
    } else if (Platform.isAndroid) {
      if (await canLaunch(url)) {
        // URLを開く
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
    // else if (Platform.isAndroid) {
    //   String? encodeQueryParameters(Map<String, String> params) {
    //     return params.entries
    //         .map((e) =>
    //             '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
    //         .join('&');
    //   }
    //
    //   final Uri emailLaunchUri = Uri(
    //     scheme: 'mailto',
    //     path: 'smith@example.com',
    //     query: encodeQueryParameters(<String, String>{
    //       'subject': 'Example Subject & Symbols are allowed!'
    //     }),
    //   );
    //
    //   var openURL = emailLaunchUri.toString();
    //
    //   launch(openURL);
    // }
  }

  // _setSettings() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('siCloud', backup);
  //   await prefs.setBool('sNotification', notification);
  //   await prefs.setInt('timeH', _time.hour);
  //   await prefs.setInt('timeM', _time.minute);
  // }

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
      // initialEntryMode: TimePickerEntryMode.input,
    );

    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
    FlutterLocalNotificationsPlugin().cancelAll();

    if (notification == true) {
      notify();
    }
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
            title: 'BACK',
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
                  setState(
                    () {
                      if (backup == false) {
                        backup = true;
                      } else {
                        backup = false;
                      }
                    },
                  );
                },
              ),
              SettingsTile.switchTile(
                title: 'Notification',
                titleTextStyle: const TextStyle(fontSize: 18),
                leading: Icon(
                  notification == false
                      ? Icons.alarm_off_outlined
                      : Icons.alarm_on_outlined,
                  size: 30,
                ),
                switchValue: notification,
                onToggle: (bool value) {
                  setState(
                    () {
                      if (notification == false) {
                        notification = true;
                        notify();
                      } else {
                        notification = false;
                        FlutterLocalNotificationsPlugin().cancelAll();
                      }
                    },
                  );
                },
              ),
              SettingsTile(
                title: 'Time',
                titleTextStyle: const TextStyle(fontSize: 18),
                leading: const Icon(
                  Icons.watch_later_outlined,
                  size: 30,
                ),
                trailing: GestureDetector(
                  onTap: () {
                    _selectTime();
                    if (notification == true) {
                      FlutterLocalNotificationsPlugin().cancelAll();
                      notify();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      ' ${_time.format(context)}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          //AndroidでのGoogle One 同期はこの中に書く
          SettingsSection(
            title: 'ACTIONS',
            titleTextStyle: const TextStyle(fontSize: 20),
            tiles: [
              SettingsTile(
                onPressed: (BuildContext context) {
                  launch('mailto:$mailAddress?subject=&body=');
                },
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
