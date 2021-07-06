// import 'package:firebase_messaging/firebase_messaging.dart';
// //e8J9beF4nB0:APA91bFCgevTUnprR6XyVlgVzNlaKdzRI4kzfEE4HGTN6VoMqIdmcrUEJvpJPk7pqmL998NiahTkgoNjg4DQqxJdvC-ki_bX31dghS6RmwJklHjNVLpTg6v67CEM6ViPeerGpI2ZiGrG

// class NotificacionesPushProvider {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

//   static Future<dynamic> misMensajesenBackground(
//       Map<String, dynamic> message) async {
//     if (message.containsKey('data')) {
//       // Handle data message
//       final dynamic data = message['data'];
//     }

//     if (message.containsKey('notification')) {
//       // Handle notification message
//       final dynamic notification = message['notification'];
//     }

//     // Or do other work.
//   }

//   initNotificaciones() async {
//     await _firebaseMessaging.requestNotificationPermissions();
//     final token = await _firebaseMessaging.getToken();

//     print('FCM TOKEN: $token');

//     _firebaseMessaging.configure(
//       onMessage: onMessage,
//       onBackgroundMessage: misMensajesenBackground,
//       onLaunch: onLaunch,
//       onResume: onResume,
//     );
//   }

//   Future<dynamic> onMessage(Map<String, dynamic> message) async {
//     print("===ON MESSAGE====");
//     print("message: $message");

//     final argumento = message['data']['comida'];
//     print('argumento: $argumento');
//   }

//   Future<dynamic> onLaunch(Map<String, dynamic> message) async {
//     print("===ON LAUNCH====");
//     print("message: $message");
//     final argumento = message['data']['comida'];
//     print('argumento: $argumento');
//   }

//   Future<dynamic> onResume(Map<String, dynamic> message) async {
//     print("===ON RESUME====");
//     print("message: $message");
//     final argumento = message['data']['comida'];
//     print('argumento: $argumento');
//   }
// }
