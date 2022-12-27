
import 'package:calendar_app_task_management/ui/notified_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../models/task.dart';

class NotifyHelper {
  FlutterLocalNotificationsPlugin
  flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  initializeNotification() async {
    _configureLocalTimezone();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("appicon");

      const InitializationSettings initializationSettings =
      InitializationSettings(
      android:initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: selectNotification);
  }

  // schedule notification
  scheduledNotification(int hour, int minutes, Task task) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        task.id!.toInt(),
        task.title,
        task.note,
        _convertTime(hour, minutes),
        //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails('Id Chanel', 'Nama Chanel',)),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      payload: "${task.title}|" + "${task.note}|",
    );
  }

  selectNotification(NotificationResponse notificationResponse) async {
    var payload = notificationResponse.payload;
    Get.to(()=>NotifiedPage(label: payload,));
  }

  // convert time
  tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);

    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }

    return scheduleDate;
  }

  // set local location
  Future<void> _configureLocalTimezone() async {
    tz.initializeTimeZones();
    // timeZone is variabel
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  // display notification
  displayNotification({required String title, required String body, required Task task}) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails('Id Chanel', 'Nama Chanel',
    importance: Importance.max, priority: Priority.high);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      task.title,
      task.note,
      platformChannelSpecifics,
      payload: "${task.title}|" + "${task.note}|",
    );
  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
/*    showDialog(
      //context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondScreen(payload),
                ),
              );
            },
          )
        ],
      ),
    );*/
  Get.dialog(const Text("Welcome to flutter"));
  }
}