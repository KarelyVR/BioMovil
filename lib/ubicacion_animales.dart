// ignore_for_file: unused_import, unused_field, non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
// import 'package:permission_handler/permission_handler.dart';


class UbicacionAnimal extends StatefulWidget {
  const UbicacionAnimal({super.key});

  @override
  State<UbicacionAnimal> createState() => _UbicacionAnimalState();
}

class _UbicacionAnimalState extends State<UbicacionAnimal> {
  final Completer<GoogleMapController> _controller = Completer();

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
    // requestLocationPermission();
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
        title: const Text(
          "Ubicacion del Tucan",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: currentLocation == null
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
    );
  }
}


// Future<void> requestLocationPermission() async {
//   final status = await Permission.location.request();

//   if (status.isGranted) {
    
//   } else if (status.isDenied) {
    
//   } else if (status.isPermanentlyDenied) {
    
//   }
// }
