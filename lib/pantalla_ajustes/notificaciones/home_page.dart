import 'dart:async';
import 'package:biomovil/pantalla_ajustes/ajustes.dart';
import 'package:flutter/material.dart';
import 'package:biomovil/pantalla_ajustes/notificaciones/Services/notifi_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Timer _timer;
  int _notificationId = 0;
  final List<Map<String, String>> _notificationMessages = [
    {
      'title': '¡Tu safari está por comenzar!',
      'body': 'El safari comenzará en 10 minutos.'
    },
    {
      'title': '¡Show de animales!',
      'body': 'No te pierdas nuestro show en vivo'
    },
    {
      'title': '¡Jornada de Elefantes y Leones!',
      'body':
          'Sumérgete en el mundo de los elefantes y deslúmbrate con la majestuosidad de los leones'
    },
    {
      'title': '¡Explora la historia en vivo!',
      'body':
          'Descubre reliquias sorprendentes y sumérgete en la historia en nuestro museo.'
    },
    {
      'title': '¡Encuentro multicolor: Tucanes y Mandriles!',
      'body':
          'Sumérgete en la diversidad de colores con nuestros tucanes y mandriles.'
    },
    {
      'title': '¡Explora la vida salvaje: Coyotes y Liebres!',
      'body':
          'Explora su hábitat y descubre su fascinante mundo en nuestro santuario de la vida animal'
    },
    {
      'title': '¡No olvides visitar nuestra galeria!',
      'body':
          'Explora la magia de la vida salvaje a través de nuestras fotografías.'
    },
    {
      'title': '¡Vuelo de color: Aves Exóticas!',
      'body':
          'Nuestra atracción te lleva a un viaje cautivador a través de las especies más exóticas y fascinantes.'
    },
  ];

  int _currentMessageIndex = 0;
  bool _notificationsActive =
      false; // Nuevo estado para activar o desactivar las notificaciones

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
      if (_notificationsActive) {
        _sendNotification();
      }
    });
  }

  void _sendNotification() {
    setState(() {
      _notificationId++;
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

  void _toggleNotifications() {
    setState(() {
      _notificationsActive = !_notificationsActive;
    });

    if (_notificationsActive) {
      _sendNotification();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>const Ajustes(),
              ),
            );
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Text(
                  'Activar notificaciones',
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _notificationsActive ? Colors.red : Colors.green,
                  ),
                  onPressed: _toggleNotifications,
                  child: Text(_notificationsActive ? 'Desactivar' : 'Activar'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
            width: 20,
          ),
          Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Column(
              children: [
                Text(
                  '¡No te pierdas ni un solo momento en nuestro increíble bioparque! Activa las notificaciones y sumérgete en una experiencia única llena de aventuras, descubrimientos y eventos emocionantes.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Recibe alertas instantáneas sobre las actividades diarias: desde las alimentaciones especiales hasta las charlas educativas con nuestros expertos en conservación. No te perderás las exhibiciones fascinantes ni las oportunidades para interactuar de cerca con la diversa vida silvestre que habita en nuestro bioparque.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
