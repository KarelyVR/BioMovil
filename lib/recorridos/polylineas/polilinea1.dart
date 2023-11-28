// ignore_for_file: avoid_print, unnecessary_import

import 'dart:async';
import 'dart:typed_data';
import 'package:biomovil/recorridos/nuevo_recorrido.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:ui' as ui;

class Polyline1 extends StatefulWidget {
  final List<String> selectedPoints;

  const Polyline1({super.key, required this.selectedPoints});

  @override
  State<Polyline1> createState() => _Polyline1State();
}

class _Polyline1State extends State<Polyline1> {

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(25.725098328491715, -100.31325851892379),
    zoom: 15
  );


  Uint8List? markerImage;

  List<String> images = [
    'assets/mandrill-marker.png',
    'assets/tucan-marker.png',
    'assets/puma-marker.png',
    'assets/tigre-marker.png',
    'assets/leon-marker.png',
    'assets/jirafa-marker.png',
    'assets/elefante-marker.png',
    'assets/avestruz-marker.png',
    'assets/baños.png',
    'assets/evento.png',
    'assets/baños.png',
    'assets/restaurante.png',
    'assets/baños.png',
    'assets/liebre-marker.png',
    'assets/evento.png',
    'assets/serpiente-marker.png',
    'assets/baños.png',
    'assets/coyote-marker.png',
    'assets/camello-marker.png',
  ];

  final Set<Polyline> _myPolyline = {};
  final List<Marker> _markers = <Marker>[];
  
  //area delimitada del parque
  List<LatLng> polygonPoints = const [
    LatLng(25.728501691054486, -100.316870949178),
    LatLng(25.730742305833193, -100.30665829150674),
    LatLng(25.711140128124455, -100.31325762086122),
    LatLng(25.708729370822947, -100.3166869634741),

  ];

  List<LatLng> myPoints = const [
     LatLng(25.72670021620236, -100.3158501262181), //mandrill
     LatLng(25.72855225173869, -100.31517131278758), //tucan
     LatLng(25.727853373793153, -100.3134063978682), //puma
     LatLng(25.726906886537034, -100.31486868597997), //tigre
     LatLng(25.729349114116648, -100.31149812513222), //leon
     LatLng(25.72949906812703, -100.31009438412333), //jirafa
     LatLng(25.730165206212476, -100.30855117545211), //elefante
     LatLng(25.728557779673796, -100.30768312058856), //avestruz
     LatLng(25.726733581232182, -100.31089508250031), //baño 1
     LatLng(25.726656258522873, -100.31216108502232), //evento 1
     LatLng(25.726772242567968, -100.31355583356353), //baño 2
     LatLng(25.722403431958984, -100.31188213521487), //restaurante
     LatLng(25.719600349564967, -100.3110238284203), //baño 3
     LatLng(25.71765852555807, -100.31222692388545), //liebre
     LatLng(25.71731917169152, -100.31402790220135), //evento 2
     LatLng(25.714664864571322, -100.31365430904526), //serpiente
     LatLng(25.71465129800604, -100.31653844957549), //baño 4
     LatLng(25.71886018518749, -100.31468389834086), //coyote
     LatLng(25.720905086852873, -100.31508169420816), //camello
  ];
  //lista de nombres de animales mostradas en infoWindow de marker
  List<String> animalNames = [
    'Mandrill',
    'Tucán',
    'Puma',
    'Tigre',
    'León',
    'Jirafa',
    'Elefante',
    'Avestruz',
    'Baños',
    'Salón de eventos 1',
    'Baños',
    'Area de restaurantes',
    'Baños',
    'Liebre',
    'Salón de eventos 2',
    'Serpiente',
    'Baños',
    'Coyote',
    'Camello',
  ];
  //lista de las imagenes de los marcadores
  Future<Uint8List> getBytesFromAssets(String path, int width) async{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  @override
  void initState(){
    super.initState();
    loadData();
  }
  //marcadores de animales
  loadData() async{
   for(int i=0; i< myPoints.length; i++){
      final Uint8List markerIcon = await getBytesFromAssets(images[i], 100);
      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: myPoints[i],
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow: InfoWindow(
            title: animalNames[i]
          )
        )
      );
      setState(() {
        
      });
    }
    
    final animalCoordinates = {
    'Mandrill': const LatLng(25.72670021620236, -100.3158501262181),
    'Tucán': const LatLng(25.72855225173869, -100.31517131278758),
    'Puma': const LatLng(25.727853373793153, -100.3134063978682),
    'Tigre': const LatLng(25.726906886537034, -100.31486868597997),
    'León': const LatLng(25.729349114116648, -100.31149812513222),
    'Jirafa': const LatLng(25.72949906812703, -100.31009438412333),
    'Elefante': const LatLng(25.730165206212476, -100.30855117545211),
    'Avestruz': const LatLng(25.728557779673796, -100.30768312058856),
    // 'Baño 1': const LatLng(25.726733581232182, -100.31089508250031),
    'Evento 1': const LatLng(25.726656258522873, -100.31216108502232),
    // 'Baño 2': const LatLng(25.726772242567968, -100.31355583356353),
    'Restaurante': const LatLng(25.722403431958984, -100.31188213521487),
    // 'Baño 3': const LatLng(25.719600349564967, -100.3110238284203),
    'Liebre': const LatLng(25.71765852555807, -100.31222692388545),
    'Evento 2': const LatLng(25.71731917169152, -100.31402790220135),
    'Serpiente': const LatLng(25.714664864571322, -100.31365430904526),
    // 'Baño 4': const LatLng(25.71465129800604, -100.31653844957549),
    'Coyote': const LatLng(25.71886018518749, -100.31468389834086),
    'Camello': const LatLng(25.720905086852873, -100.31508169420816),
  };

   // Add polylines for the selected animals
    for (int i = 0; i < widget.selectedPoints.length - 1; i++) {
      String animal1 = widget.selectedPoints[i];
      String animal2 = widget.selectedPoints[i + 1];

      if (animalCoordinates.containsKey(animal1) && animalCoordinates.containsKey(animal2)) {
        _myPolyline.add(
          Polyline(
            polylineId: PolylineId('$animal1-$animal2'),
            points: [animalCoordinates[animal1]!, animalCoordinates[animal2]!],
            color: Colors.purple,
          ),
        );
      }
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
  //boton para ir a ubicacion actual
  packData(){
    getUserLocation().then((value)async{
      print('Mi ubicacion');
      print('${value.latitude} ${value.longitude}');
      _markers.add(
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
  //diseño de pagina
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personaliza tu ruta'),
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Reiniciar el contenido de la página anterior
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>const SelectionScreen(initialSelectedAnimals: [],),
              ),
            );
          },
        ),
      ),
      //mapa de google maps
      body: SafeArea(
        child: GoogleMap(
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
          onMapCreated: (GoogleMapController controller)
          {
            _controller.complete(controller);
          },
        ), 
      ),
      //boton flotante de ubicacion actual
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