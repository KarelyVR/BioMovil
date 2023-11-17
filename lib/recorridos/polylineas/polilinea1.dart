// ignore_for_file: use_key_in_widget_constructors, avoid_print, unused_local_variable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Polyline1 extends StatefulWidget {

  @override
  State<Polyline1> createState() => _Polyline1State();
}

class _Polyline1State extends State<Polyline1> {

  final Completer<GoogleMapController> _controller = Completer();
 

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(25.725098328491715, -100.31325851892379),
    zoom: 15
  );

  final Set<Marker> myMarker = {};
  final Set<Polyline> _myPolyline = {};

  List<LatLng> myPoints = [
    const LatLng(25.723530728639723, -100.31588996140242), //camello
    const LatLng(25.72581541820319, -100.31675433366625), //coyote
    const LatLng(25.727651953561082, -100.31438138720091), //liebre
    const LatLng(25.727174457104127, -100.31289727633997), //serpiente
    const LatLng(25.729454, -100.307161), //avestruz
    const LatLng(25.72504406489367, -100.31162518132197), //elefante
    const LatLng(25.72816844513416, -100.31069607636253), //jirafa
    const LatLng(25.72093772888926, -100.31371467851994), //leon
    const LatLng(25.719376595627796, -100.31620581883989), //mandrill
    const LatLng(25.718871429419682, -100.3109417424927), //puma
    const LatLng(25.71322673037063, -100.31614316051954), //tigre
    const LatLng(25.724133513174035, -100.31064160106247) //tucan
  ];

  @override
  void initState(){
    super.initState();
    //packData();

    for(int a = 0; a<myPoints.length;a++){
      myMarker.add(
        Marker(
          markerId: MarkerId(a.toString()),
          position: myPoints[a],
          infoWindow: const InfoWindow(
            title: 'Bioparque Estrella',
            snippet: '10 de 10 estrellas'
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );

      setState(() {});

      _myPolyline.add(
        Polyline(polylineId: const PolylineId('Primero'),
        points: myPoints,
        color: Colors.cyan
        ),
      );
    }
  }

  //Encontrar ubicacion actual
  Future<Position> getUserLocation() async{
    await Geolocator.requestPermission().then((value)
    {}).onError((error, stackTrace) {
      print('error $error');
    });
    return await Geolocator.getCurrentPosition();
  }

  packData(){
    getUserLocation().then((value)async{
      print('Mi ubicacion');
      print('${value.latitude} ${value.longitude}');
      myMarker.add(
        Marker(
          markerId: const MarkerId('Actual'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: const InfoWindow(
            title: 'Mi Ubicacion Actual'
          ),
        ),
      );
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 15,
      );
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis rutas'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _initialPosition,
          mapType: MapType.normal,
          markers: myMarker,
          polylines: _myPolyline,
          onMapCreated: (GoogleMapController controller)
          {
            _controller.complete(controller);
          },
        ), 
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        onPressed: ()
        {
          packData();
        },
        child: const Icon(Icons.radio_button_off),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}