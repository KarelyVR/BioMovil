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
  // Agrega más rutas de imágenes según sea necesario
];

class DetalleImagen extends StatelessWidget {
  final String imagePath;

  const DetalleImagen({required this.imagePath, Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de la Imagen'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Hero(
          tag: imagePath, // Utiliza el mismo tag que en la pantalla de galería
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}



class Galeria extends StatelessWidget {
  const Galeria({super.key});

  get gridDelegate => null;

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
              // Navegar a la pantalla de detalle cuando se toque una imagen
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetalleImagen(imagePath: imagePath),
                ),
              );
            },
            child: Hero(
              tag: imagePath, // Utiliza la misma ruta de imagen como tag
              child: buildImageCell(imagePath),
            ),
          );
        }).toList(),
      ),
    );
  }
}
