// ignore_for_file: library_private_types_in_public_api, unused_field

import 'dart:isolate';
import 'dart:async';
import 'package:biomovil/principal/mas_informacion.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:biomovil/animales/menu_desplegable.dart' as menu;

class Mapa extends StatefulWidget {
  const Mapa({super.key});

  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(25.725098328491715, -100.31325851892379), 
    zoom: 15
  );

  //area delimitada del parque
  List<LatLng> polygonPoints = const [
    LatLng(25.728501691054486, -100.316870949178),
    LatLng(25.730742305833193, -100.30665829150674),
    LatLng(25.711140128124455, -100.31325762086122),
    LatLng(25.708729370822947, -100.3166869634741),

  ];

  late ReceivePort _receivePort;

  @override
  void initState() {
    super.initState();
    _receivePort = ReceivePort();
    _initIsolate();
  }

  void _initIsolate() async {
    await Isolate.spawn(_isolateEntryPoint, _receivePort.sendPort);
    _receivePort.listen((message) {});
  }

  static void _isolateEntryPoint(SendPort sendPort) {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);

    receivePort.listen((message) {});
  }

  //diseño de pagina
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        title: const Text(
          'Ubicación del bioparque',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
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
          child: Container(
            padding: const EdgeInsets.all(10),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 28,
            ),
          ),
        ),
        actions: [
          Builder(
            builder: (BuildContext context) {
              return InkWell(
                onTap: () {
                  // Abre el drawer (menú lateral derecho)
                  Scaffold.of(context).openDrawer();
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: const Icon(
                    Icons.sort_rounded,
                    size: 28,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      drawer: const menu.NavigationDrawer(),
      //mapa de google maps
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _initialPosition,
          mapType: MapType.normal,
          polygons: {
            Polygon(
              polygonId: const PolygonId("1"),
              points: polygonPoints,
              fillColor: const Color(0xFF7A7A7A).withOpacity(0.2),
              strokeWidth: 2,
            ),
          },
          onMapCreated: (GoogleMapController controller)
          {
            _controller.complete(controller);
          },
        ), 
      ),
    );
  }
}
