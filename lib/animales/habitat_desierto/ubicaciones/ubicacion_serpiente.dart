import 'dart:async';
import 'package:biomovil/animales/habitat_desierto/serpiente.dart';
import 'package:biomovil/animales/menu_desplegable.dart' as menu;
import 'package:biomovil/themes/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class UbicacionSerpiente extends StatefulWidget {
  const UbicacionSerpiente({super.key});

  @override
  State<UbicacionSerpiente> createState() => _UbicacionSerpienteState();
}

class _UbicacionSerpienteState extends State<UbicacionSerpiente> {
  final Completer<GoogleMapController> _controller = Completer();
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
  static const LatLng fuenteUbicacion = LatLng(25.72494, -100.31341);
  static const LatLng destino = LatLng(25.727174457104127, -100.31289727633997);

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

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

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(fuenteUbicacion.latitude, fuenteUbicacion.longitude),
      PointLatLng(destino.latitude, destino.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        )
      );
      setState(() {});
    }
  }

    void setCustomMarkerIcon(){
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty, 
    "assets/pin-destino.png").
    then((icon){
      sourceIcon = icon;
    });
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty, 
    "assets/pin-actual.png").
    then((icon){
      destinationIcon = icon;
    });
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty, 
    "assets/pin-origen.png").
    then((icon){
      currentLocationIcon = icon;
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await getCurrentLocation();
    await getPolyPoints();
    setCustomMarkerIcon();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Ubicación",
          style: TextStyle(color: kWhite, fontSize: 20),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Serpiente(),
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
        currentLocation == null
          ? const Center(child: Text("Cargando"))
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: 13.5,
              ),
              polylines: {
                Polyline(
                  polylineId: const PolylineId("route"),
                  points: polylineCoordinates,
                  color: Colors.blue,
                  width: 6,
                ),
              },
              markers: {
                Marker(
                  markerId: const MarkerId("currentLocation"),
                  icon:currentLocationIcon,
                  position: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!
                  ),
                ),
                Marker(
                  markerId: const MarkerId("source"),
                  icon: sourceIcon,
                  position: fuenteUbicacion,
                ),
                Marker(
                  markerId: const MarkerId("destination"),
                  icon: destinationIcon,
                  position: destino,
                ),
              },
              onMapCreated: (MapController){
                _controller.complete(MapController);
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
        'Serpiente',
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
          backgroundImage: AssetImage('assets/animales/desierto/serpiente_cascabel.jpg'),
        ),
      ),
    ],
  ),
);
  }
}
