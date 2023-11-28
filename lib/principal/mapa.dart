// ignore_for_file: library_private_types_in_public_api

import 'dart:isolate';
import 'package:biomovil/principal/mas_informacion.dart';
import 'package:flutter/material.dart';


class Mapa extends StatefulWidget {
  const Mapa({super.key});

  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  double _zoomLevel = 1.0;
  late ReceivePort _receivePort;

  @override
  void initState() {
    super.initState();
    _receivePort = ReceivePort();
    _initIsolate();
  }

  void _initIsolate() async {
    await Isolate.spawn(_isolateEntryPoint, _receivePort.sendPort);
    _receivePort.listen((message) {
      // Manejar mensajes desde el isolate (si es necesario)
    });
  }

  static void _isolateEntryPoint(SendPort sendPort) {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);

    receivePort.listen((message) {
      // Realizar procesamiento en segundo plano aquí (si es necesario)
      // sendPort.send(result); // Enviar resultado de vuelta al main isolate
    });
  }

  void _zoomIn() {
    setState(() {
      _zoomLevel += 0.5;
    });
  }

  void _zoomOut() {
    setState(() {
      _zoomLevel -= 0.5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubicación'),
        backgroundColor: Colors.green,
        elevation: 0,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MoreInfoScreen(),
              ),
            );
          },
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Center(
        child: GestureDetector(
          onScaleUpdate: (details) {
            setState(() {
              _zoomLevel = details.scale;
            });
          },
          child: Transform.scale(
            scale: _zoomLevel,
            child: Image.asset(
              'assets/mapa_mas_info.jpg',
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _zoomIn,
            backgroundColor: Colors.green,
            child: const Icon(Icons.add, color: Colors.black),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: _zoomOut,
            backgroundColor: Colors.green,
            child: const Icon(Icons.remove, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
