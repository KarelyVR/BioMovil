import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class DetalleImagen extends StatelessWidget {
  const DetalleImagen({required this.imagePath, Key? key}) : super(key: key);
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Cerrar la pantalla al tocar fuera de la imagen
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: Colors.black, // Establecer el color de fondo a negro
        appBar: AppBar(
          title: const Text('Detalle de la Imagen'),
          backgroundColor: Colors.transparent, // Hacer que la barra de la aplicación sea transparente
          elevation: 0, // Quitar la sombra de la barra de la aplicación
          automaticallyImplyLeading: false, // Oculta la flecha de retroceso
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text("Presione dos veces para \nacercar la imagen", style: TextStyle(fontSize:16, color: Colors.white),),
            ),
            Hero(
              tag: imagePath,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: PhotoView(
                  imageProvider: AssetImage(imagePath),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                ),
              ),
            ),
            const SizedBox(height: 16.0), // Espacio entre la imagen y el texto
            const Center(
              child: Text(
                'Presione cualquier lugar fuera \nde la imagen para volver',
                style: TextStyle(fontSize: 16.0, color: Colors.white), // Establecer el color del texto a blanco
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GaleriaFotos extends StatelessWidget {
  const GaleriaFotos({Key? key}) : super(key: key);

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
    margin: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
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
        fit: BoxFit.cover,
      ),
    ),
  );
}

List<String> imagePaths = [
  'assets/animales/tropical/toucan1.jpg',
  'assets/animales/tropical/mandrill5.jpg',
  'assets/animales/tropical/puma.jpg',
  'assets/animales/tropical/tigre.jpg',
  'assets/animales/desierto/camello.jpg',
  'assets/animales/desierto/coyote.jpg',
  'assets/animales/desierto/serpiente1.jpg',
  'assets/animales/desierto/liebre.jpeg',
  'assets/animales/sabana/leon.jpg',
  'assets/animales/sabana/jirafa1.jpeg',
  'assets/animales/sabana/elefante.jpg',
  'assets/animales/sabana/avestruz.jpg',
];

class Galeria extends StatelessWidget {
  const Galeria({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Galería de Fotos',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: GridView.extent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        children: imagePaths.map((imagePath) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetalleImagen(imagePath: imagePath),
                ),
              );
            },
            child: Hero(
              tag: imagePath,
              child: buildImageCell(imagePath),
            ),
          );
        }).toList(),
      ),
    );
  }
}
