// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'Services/notifi_service.dart';
import 'home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  NotificationService().initNotification();

  runApp(const notificaciones());
}

class notificaciones extends StatelessWidget {
  const notificaciones({super.key});

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
