// ignore_for_file: sized_box_for_whitespace

import 'package:biomovil/principal/pagina_principal.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:biomovil/animales/menu_desplegable.dart' as menu;

class DetalleImagen extends StatelessWidget {
  const DetalleImagen({required this.imagePaths, required this.initialIndex, Key? key}) : super(key: key);

  final List<String> imagePaths;
  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CarouselSlider.builder(
            itemCount: imagePaths.length,
            options: CarouselOptions(
              height: double.infinity,
              viewportFraction: 1.0,
              initialPage: initialIndex,
              enableInfiniteScroll: false,
            ),
            itemBuilder: (context, index, _) {
              return Container(
                width: double.infinity,
                child: PhotoView(
                  imageProvider: AssetImage(imagePaths[index]),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                ),
              );
            },
          ),
          Positioned(
            top: 40.0,
            right: 16.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Galeria extends StatelessWidget {
  const Galeria({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        title: const Text(
          'Galeria de imágenes',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PaginaPrincipal(),
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
      body: GridView.extent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        children: imagePaths.asMap().entries.map((entry) {
          final index = entry.key;
          final imagePath = entry.value;
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetalleImagen(
                    imagePaths: imagePaths,
                    initialIndex: index,
                  ),
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

  static List<String> imagePaths = [
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
}


