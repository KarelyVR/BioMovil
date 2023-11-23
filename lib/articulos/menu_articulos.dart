// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:biomovil/articulos/e_renovable.dart';
import 'package:biomovil/articulos/marpol.dart';
import 'package:biomovil/articulos/panda.dart';
import 'package:biomovil/articulos/pangolin.dart';
import 'package:biomovil/articulos/pez_matusalen.dart';
import 'package:biomovil/articulos/tarantula.dart';
import 'package:biomovil/principal/pagina_principal.dart';
import 'package:biomovil/animales/menu_desplegable.dart' as menu;

class MenuArticulos extends StatelessWidget {
  final List<ArticulosCardData> cardData = [
    ArticulosCardData("Pangolin", "assets/articulos/pangolin.jpg"),
    ArticulosCardData("Pez", "assets/articulos/pez.jpg"),
    ArticulosCardData("Tarantula", "assets/articulos/tarantula.jpg"),
    ArticulosCardData("Panda", "assets/articulos/panda.jpg"),
    ArticulosCardData("Contaminación", "assets/articulos/contaminacion.jpg"),
    ArticulosCardData("Energía Renovable", "assets/articulos/renovables1.jpg"),
  ];

  final List<String> menuItems = [
    "Pagina principal",
    "Animales",
    "Codigo QR",
    "Recorridos",
    "Ajustes",
  ];

  final String selectedMenuItem;

  MenuArticulos({Key? key}) : selectedMenuItem = "Ultimas noticias", super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
            'Ultimas noticias',
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
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 40.0),
                  ...cardData.map((data) {
                    return GestureDetector(
                      onTap: () {
                        if (data.habitat == "Pangolin") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Pangolin()),
                          );
                        } else if (data.habitat == "Pez") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PezMatusalem()),
                          );
                        } else if (data.habitat == "Tarantula") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Tarantula()),
                          );
                        } else if (data.habitat == "Panda") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Panda()),
                          );
                        } else if (data.habitat == "Contaminación") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Contaminacion()),
                          );
                        } else if (data.habitat == "Energía Renovable") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Renovables()),
                          );
                        }
                      },
                      child: AnimalCard(data: data),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ArticulosCardData {
  final String habitat;
  final String imagePath;

  ArticulosCardData(this.habitat, this.imagePath);
}

class AnimalCard extends StatelessWidget {
  final ArticulosCardData data;

  const AnimalCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          height: 170,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(data.imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Text(
              data.habitat,
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}