import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

var box = Hive.box('myBox');
bool backups = box.get('backup', defaultValue: false);
bool notifications = box.get('notice', defaultValue: false);
TimeOfDay time = box.get(
  'timers',
  defaultValue: const TimeOfDay(hour: 21, minute: 00),
);

class _SettingsState extends State<Settings> {
  Future putBackup(backup) async => await box.put('backup', backup);
  Future putNotice(notice) async => await box.put('notice', notice);
  Future putTimers(timers) async => await box.put('timers', timers);

  final mailAddress = 'hiroshu.diary@mail.com';
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
              Time(time.hour, time.minute),
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
              Time(time.hour, time.minute),
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
    } else if (Platform.isAndroid) {
      String? encodeQueryParameters(Map<String, String> params) {
        return params.entries
            .map((e) =>
                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
            .join('&');
      }

      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'smith@example.com',
        query: encodeQueryParameters(<String, String>{
          'subject': 'Example Subject & Symbols are allowed!'
        }),
      );

      var openURL = emailLaunchUri.toString();

      launch(openURL);
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: time,
    );

    if (newTime != null) {
      setState(() => time = newTime);
    }
    FlutterLocalNotificationsPlugin().cancelAll();

    if (notifications == true) {
      notify();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box('myBox').listenable(),
      builder: (context, box, widget) {
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
                titlePadding: const EdgeInsets.only(top: 15, left: 15),
                titleTextStyle: const TextStyle(fontSize: 20),
                tiles: [
                  SettingsTile.switchTile(
                    title: 'Google Drive',
                    titleTextStyle: const TextStyle(fontSize: 18),
                    leading: Icon(
                      backups == false
                          ? FontAwesomeIcons.solidTimesCircle
                          : FontAwesomeIcons.googleDrive,
                      size: 30,
                    ),
                    switchValue: backups,
                    onToggle: (bool value) {
                      setState(
                        () {
                          if (backups == false) {
                            backups = true;
                            putBackup(true);
                          } else {
                            backups = false;
                            putBackup(false);
                          }
                        },
                      );
                    },
                  ),
                  SettingsTile.switchTile(
                    title: 'Notification',
                    titleTextStyle: const TextStyle(fontSize: 18),
                    leading: Icon(
                      notifications == false
                          ? Icons.alarm_off_outlined
                          : Icons.alarm_on_outlined,
                      size: 30,
                    ),
                    switchValue: notifications,
                    onToggle: (bool value) {
                      setState(
                        () {
                          if (notifications == false) {
                            notifications = true;
                            putNotice(true);
                            notify();
                          } else {
                            notifications = false;
                            putNotice(false);
                            FlutterLocalNotificationsPlugin().cancelAll();
                          }
                        },
                      );
                    },
                  ),
                  SettingsTile(
                    title: 'Time',
                    titleTextStyle: const TextStyle(fontSize: 18),
                    leading: const Icon(Icons.watch_later_outlined, size: 30),
                    trailing: GestureDetector(
                      onTap: () {
                        _selectTime();
                        if (notifications == true) {
                          FlutterLocalNotificationsPlugin().cancelAll();
                          notify();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          ' ${time.format(context)}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SettingsSection(
                title: 'ACTIONS',
                titlePadding: const EdgeInsets.only(top: 20, left: 15),
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
                    leading: Platform.isIOS
                        ? const Icon(FontAwesomeIcons.appStore, size: 30)
                        : const Icon(FontAwesomeIcons.googlePlay, size: 30),
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
                titlePadding: const EdgeInsets.only(top: 20, left: 15),
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
      },
    );
  }
}
