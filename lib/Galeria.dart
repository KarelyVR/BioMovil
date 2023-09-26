import 'package:flutter/material.dart';

void main() {
  runApp(GaleriaFotos());
}

class GaleriaFotos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Galeria(),
    );
  }
}

Widget buildImageCell(String imagePath) {
  return Container(
    margin: EdgeInsets.all(8.0), // Margen entre las celdas de imagen
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0), // Borde redondeado
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5), // Sombra
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover, // Ajusta la imagen al tamaño de la celda
      ),
    ),
  );
}

List<String> imagePaths = [
  'assets/imagen1.jpg',
  'assets/imagen2.jpg',
  'assets/imagen3.jpg',
  'assets/imagen4.jpg',
  // Agrega más rutas de imágenes según sea necesario
];


class Galeria extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Galeria de Fotos',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        backgroundColor: Colors.green,
      ),
      body: GridView.builder(
        itemCount: imagePaths.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return buildImageCell(imagePaths[index]);
        },
      ),

    );
  }
}
