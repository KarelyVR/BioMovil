import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  runApp(const NotificacionesApp());
}

class NotificacionesApp extends StatelessWidget {
  const NotificacionesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notificaciones',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Notificaciones'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Timer _timer;
  int _notificationId = 0;
  List<Map<String, String>> _notificationMessages = [
    {
      'title': '¡Tu safari está por comenzar!',
      'body': 'El safari comenzará en 10 minutos.'
    },
    {
      'title': '¡Show de animales!',
      'body': 'No te pierdas nuestro show en vivo'
    },
    // ... otros mensajes de notificación
  ];

  int _currentMessageIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 70), (timer) {
      _sendNotification();
    });
  }

  void _sendNotification() {
    setState(() {
      _notificationId++;
      // Cambiar al siguiente mensaje de la lista
      _currentMessageIndex =
          (_currentMessageIndex + 1) % _notificationMessages.length;
    });

    final message = _notificationMessages[_currentMessageIndex];
    NotificationService().showNotification(
      id: _notificationId,
      title: message['title']!,
      body: message['body']!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Enviar notificaciones'),
          onPressed: () {
            _sendNotification();
          },
        ),
      ),
    );
  }
}

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('logo_bioparque');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await notificationsPlugin.initialize(
      initializationSettings,
    );
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'AppBiomovil',
        'Biomovil',
        importance: Importance.max,
      ),
    );
  }

  Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    return notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails(),
    );
  }
}
