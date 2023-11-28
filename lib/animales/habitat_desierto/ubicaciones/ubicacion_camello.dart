// ignore_for_file: avoid_print, unused_import, unnecessary_import, unused_local_variable, avoid_function_literals_in_foreach_calls, non_constant_identifier_names

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:biomovil/animales/habitat_desierto/camello.dart';
import 'package:biomovil/animales/menu_desplegable.dart' as menu;
import 'package:biomovil/themes/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

class UbicacionCamello extends StatefulWidget {
  const UbicacionCamello({super.key});

  @override
  State<UbicacionCamello> createState() => _UbicacionCamelloState();
}

class _UbicacionCamelloState extends State<UbicacionCamello> {

  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? _mapController;

  final List<String> menuItems = [
    "Pagina principal",
    "Animales",
    "Codigo QR",
    "Ubicacion",
    "Ajustes",
  ];
  String selectedMenuItem = "Animales";

  String google_api_key =
      "AIzaSyB0TLjPkqVU3gavsbEFl_29z85d_3FnUnM";

  // static const LatLng fuenteUbicacion = LatLng(25.72494, -100.31341);
  // static const LatLng destino = LatLng(25.724133513174035, -100.31064160106247);

  static const CameraPosition _initialPosition = CameraPosition(
      target: LatLng(25.725098328491715, -100.31325851892379),
      zoom: 16
  );

  Uint8List? markerImage;

  List<String> images = [
    'assets/baños.png',
    'assets/evento.png',
    'assets/baños.png',
    'assets/restaurante.png',
    'assets/baños.png',
    'assets/evento.png',
    'assets/baños.png',
    'assets/camello-marker.png',
  ];

  Future<Uint8List> getBytesFromAssets(String path, int width) async{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  final Set<Polyline> _myPolyline = {};
  final List<Marker> _markers = <Marker>[];

  List<LatLng> polylineCoordinates = [];

  List<LatLng> polygonPoints = const [
    LatLng(25.728501691054486, -100.316870949178),
    LatLng(25.730560561980912, -100.3116352460716),
    LatLng(25.730742305833193, -100.30665829150674),
    LatLng(25.711140128124455, -100.31325762086122),
    LatLng(25.708729370822947, -100.3166869634741),
  ];

  List<LatLng> myPoints = const [
    LatLng(25.726733581232182, -100.31089508250031),//baño 1
    LatLng(25.726656258522873, -100.31216108502232),//evento 1
    LatLng(25.726772242567968, -100.31355583356353),//baño 2
    LatLng(25.722403431958984, -100.31188213521487),//restaurante
    LatLng(25.719600349564967, -100.3110238284203),//baño 3
    LatLng(25.71731917169152, -100.31402790220135),//evento 2
    LatLng(25.71465129800604, -100.31653844957549),//baño 4
    LatLng(25.720905086852873, -100.31508169420816), //camello
  ];

  List<String> description = [
    'Baños',
    'Salón de eventos 1',
    'Baños',
    'Area de restaurantes',
    'Baños',
    'Salón de eventos 2',
    'Baños',
    'Camello'
  ];

  @override
  void initState(){
    super.initState();
    loadMapData();
  }

  void loadMapData() async {
    await loadData();
    await getPolyPoints();
  }

  loadData() async{
    //agregar marcadores de mis puntos
    for(int i=0; i< myPoints.length; i++){
      final Uint8List markerIcon = await getBytesFromAssets(images[i], 100);
      _markers.add(
          Marker(
              markerId: MarkerId(i.toString()),
              position: myPoints[i],
              icon: BitmapDescriptor.fromBytes(markerIcon),
              infoWindow: InfoWindow(
                  title: description[i]
              )
          )
      );
      setState(() {

      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
      // Llama a la función para enfocar el punto deseado.
      focusOnPoint(const LatLng(25.720905086852873, -100.31508169420816));
    });
  }

  void focusOnPoint(LatLng targetPoint) async {
    if (_mapController != null) {
      await _mapController!.animateCamera(
        CameraUpdate.newLatLng(targetPoint),
      );
    }
  }

  LocationData? currentLocation;

  Future<void> getCurrentLocation() async {
    Location location = Location();

    final ubicacion = await location.getLocation();
    setState(() {
      currentLocation = ubicacion;
    });

    GoogleMapController googleMapController = await _controller.future;
  }

  Future<void> getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    Position currentPosition = await getUserLocation();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      const PointLatLng(25.720905086852873, -100.31508169420816),
      PointLatLng(currentPosition.latitude, currentPosition.longitude),
       travelMode: TravelMode.walking,
    );

    _markers.add(
      Marker(
        markerId: const MarkerId('currentLocationMarker'),
        position: LatLng(currentPosition.latitude, currentPosition.longitude),
        infoWindow: const InfoWindow(
          title: 'Ubicación Actual',
        ),
      ),
    );

    if (result.points.isNotEmpty) {
      _myPolyline.clear(); // Elimina cualquier polilínea existente
      result.points.forEach(
            (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );

      Polyline polyline = Polyline(
        polylineId: const PolylineId("route"),
        points: polylineCoordinates,
        color: Colors.orange,
        width: 6,
      );

      _myPolyline.add(polyline); // Agregar la polilínea al conjunto _myPolyline
      print("_myPolyline length: ${_myPolyline.length}");
      setState(() {
        print("Setting state");
      });
    }
  }

  Future<Position> getUserLocation() async {
    await Geolocator.requestPermission().then((value) {}).onError((error, stackTrace) {
      print('error $error');
    });

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Ubicación del animal",
          style: TextStyle(color: kWhite, fontSize: 20),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Camello(),
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
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialPosition,
            mapType: MapType.normal,
            markers: Set<Marker>.of(_markers),
            polylines: _myPolyline,
            polygons: {
              Polygon(
                polygonId: const PolygonId("1"),
                points: polygonPoints,
                fillColor: const Color(0xFF7A7A7A).withOpacity(0.2),
                strokeWidth: 2,
              ),
            },
            onMapCreated: (GoogleMapController controller) {
              _onMapCreated(controller);
            },
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomContainer(),
          ),
        ],
      ),
    );
  }
}


class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Camello',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black,
                width: 4,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const CircleAvatar(
              radius: 48,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/animales/desierto/camello.jpg'),
            ),
          ),
        ],
      ),
    );
  }
}