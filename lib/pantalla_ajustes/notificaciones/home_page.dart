// ignore_for_file: prefer_final_fields, unused_element

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:biomovil/pantalla_ajustes/notificaciones/Services/notifi_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final GlobalKey<_MyHomePageState> _myHomePageKey = GlobalKey<_MyHomePageState>();

  late Timer _timer;
  int _notificationId = 0;
  List<Map<String, String>> _notificationMessages = [
    {'title': '¡Tu safari está por comenzar!', 'body': 'El safari comenzará en 10 minutos.'},
    {'title': '¡Show de animales!', 'body': 'No te pierdas nuestro show en vivo'},
    {'title': '¡Jornada de Elefantes y Leones!', 'body': 'Sumérgete en el mundo de los elefantes y deslúmbrate con la majestuosidad de los leones'},
    {'title': '¡Explora la historia en vivo!', 'body': 'Descubre reliquias sorprendentes y sumérgete en la historia en nuestro museo.'},
    {'title': '¡Encuentro multicolor: Tucanes y Mandriles!', 'body': 'Sumérgete en la diversidad de colores con nuestros tucanes y mandriles.'},
    {'title': '¡Explora la vida salvaje: Coyotes y Liebres!', 'body': 'Explora su hábitat y descubre su fascinante mundo en nuestro santuario de la vida animal'},
    {'title': '¡No olvides visitar nuestra galeria!', 'body': 'Explora la magia de la vida salvaje a través de nuestras fotografías.'},
    {'title': '¡Vuelo de color: Aves Exóticas!', 'body': 'Nuestra atracción te lleva a un viaje cautivador a través de las especies más exóticas y fascinantes.'},
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
      _currentMessageIndex = (_currentMessageIndex + 1) % _notificationMessages.length;
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

