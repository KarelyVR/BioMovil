import 'package:biomovil/principal/mas_informacion.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Mapa(),
    );
  }
}

class Mapa extends StatefulWidget {
  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  double _zoomLevel = 1.0;

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
        title: Text('Ubicación'),
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
          child: Icon(Icons.arrow_back, color: Colors.white),
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
            child: Icon(Icons.add, color: Colors.black),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: _zoomOut,
            backgroundColor: Colors.green,
            child: Icon(Icons.remove, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
