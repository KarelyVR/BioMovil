// ignore_for_file: unused_import, unused_field, non_constant_identifier_names, avoid_function_literals_in_foreach_calls, avoid_print

import 'dart:async';
import 'package:biomovil/animales/habitat_sabana/jirafa.dart';
import 'package:biomovil/animales/menu_desplegable.dart' as menu;
import 'package:biomovil/themes/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class UbicacionJirafa extends StatefulWidget {
  const UbicacionJirafa({super.key});

  @override
  State<UbicacionJirafa> createState() => _UbicacionJirafaState();
}

class _UbicacionJirafaState extends State<UbicacionJirafa> {
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
  static const LatLng fuenteUbicacion = LatLng(37.33500926, -122.03272188);
  static const LatLng destino = LatLng(37.33429383, -122.06600055);

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

    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 13.5,
          target: LatLng(
            newLoc.latitude!,
            newLoc.longitude!,
          )
        )
      ));
      setState(() {});
    });
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
    "assets/pin-origen.png").
    then((icon){
      sourceIcon = icon;
    });
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty, 
    "assets/pin-destino.png").
    then((icon){
      destinationIcon = icon;
    });
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty, 
    "assets/pin-actual.png").
    then((icon){
      currentLocationIcon = icon;
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeData(); // Llama a una función para iniciar la obtención de ubicación y puntos polilínea.
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
                builder: (context) => Jirafa(),
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
            child: CustomContainer(), // Agrega el contenedor personalizado
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
  height: MediaQuery.of(context).size.height * 0.3, // El 40% de la pantalla
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(30),
      topRight: Radius.circular(30),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5), // Color de la sombra
        spreadRadius: 5, // Radio de propagación de la sombra
        blurRadius: 7, // Radio de desenfoque de la sombra
        offset: const Offset(0, 3), // Desplazamiento de la sombra (eje x, eje y)
      ),
    ],
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        'Jirafa',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 20),
      Container(
        width: 100, // Ancho del círculo
        height: 100, // Alto del círculo
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black, // Color del borde (negro)
            width: 4, // Ancho del borde (ajusta según tus preferencias)
          ),
          boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Color de la sombra
                spreadRadius: 5, // Radio de propagación de la sombra
                blurRadius: 7, // Radio de desenfoque de la sombra
                offset: const Offset(0, 3), // Desplazamiento de la sombra (eje x, eje y)
              ),
            ],
        ),
        child: const CircleAvatar(
          radius: 48, // Radio del círculo interno
          backgroundColor: Colors.transparent, // Fondo transparente para que el borde sea visible
          backgroundImage: AssetImage('assets/animales/sabana/jirafa.jpg'),
        ),
      ),
    ],
  ),
);
  }
}
