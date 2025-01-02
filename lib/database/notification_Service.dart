// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter/material.dart';
// import 'package:todoo_list/screens/home_screen.dart';

// class NotificationService {
//   static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   // Define a GlobalKey for NavigatorState to access context anywhere in the app
//   static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//   // Initialize the notification service
//   static Future<void> initialize() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon'); // You need to set an icon for your notifications

//     const InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//     );

//     // Initialize notifications with 'onSelectNotification'
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onSelectNotification: _onSelectNotification,
//     );
//   }

//   // This will be called when the user taps the notification
//   static Future<void> _onSelectNotification(String? payload) async {
//     if (payload != null) {
//       debugPrint('Notification Payload: $payload');
//     }

//     // Use the navigatorKey to perform navigation after tapping the notification
//     navigatorKey.currentState?.push(
//       MaterialPageRoute(builder: (context) => HomeScreen()),
//     );
//   }

//   // Show notification method
//   static Future<void> showNotification(String title, String body) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'your_channel_id',
//       'your_channel_name',
//       channelDescription: 'your_channel_description',
//       importance: Importance.high,
//       priority: Priority.high,
//       showWhen: false,
//     );

//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);

//     await flutterLocalNotificationsPlugin.show(
//       0,
//       title,
//       body,
//       platformChannelSpecifics,
//       payload: 'item x', // Optional data that can be used when the notification is tapped
//     );
//   }
// }
