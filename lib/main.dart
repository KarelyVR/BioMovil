// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:biomovil/ubicacion_animales.dart';
import 'package:biomovil/animales_detalles.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
      routes: {
        '/animales_detalles': (context) => const AnimalesDetalles(),
        '/ubicacion_animales': (context) => const UbicacionAnimal(),
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla Principal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/animales_detalles');
              },
              child: const Text('Ir a Detalles de Animales'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ubicacion_animales');
              },
              child: const Text('Ir a Ubicación de Animales'),
            ),
          ],
        ),
      ),
    );
  }
}
<<<<<<< Updated upstream
=======

>>>>>>> Stashed changes
