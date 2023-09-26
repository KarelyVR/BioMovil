// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:biomovil/animales/ubicacion_animales.dart';
import 'package:biomovil/animales/menu_habitats.dart';
import 'package:biomovil/principal/galeria_imagenes.dart';
import 'package:biomovil/recorridos/recorridos_ubicacion.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainScreen(),
      routes: {
        '/ubicacion_animales': (context) => const UbicacionAnimal(),
        '/menu_habitats': (context) => MenuHabitats(),
        '/recorridos_ubicacion': (context) => const Recorridos(),
        '/galeria_imagenes':(context) => const Galeria(),
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
                Navigator.pushNamed(context, '/menu_habitats');
              },
              child: const Text('Ir a habitats'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ubicacion_animales');
              },
              child: const Text('Ir a Ubicación de Animales'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/recorridos_ubicacion');
              },
              child: const Text('Ir a recorridos'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/galeria_imagenes');
              },
              child: const Text('Ir a galeria'),
            ),
          ],
        ),
      ),
    );
  }
}
