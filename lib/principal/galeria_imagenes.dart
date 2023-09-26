import 'package:flutter/material.dart';

class GaleriaFotos extends StatelessWidget {
  const GaleriaFotos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Galeria(),
    );
  }
}

Widget buildImageCell(String imagePath) {
  return Container(
    margin: const EdgeInsets.all(8.0), // Margen entre las celdas de imagen
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0), // Borde redondeado
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5), // Sombra
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
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
  'assets/galeria/galeria1.jpg',
  'assets/galeria/galeria2.jpg',
  'assets/galeria/galeria3.jpg',
  'assets/galeria/galeria4.jpg',
  // Agrega más rutas de imágenes según sea necesario
];


class Galeria extends StatelessWidget {
  const Galeria({super.key});

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
