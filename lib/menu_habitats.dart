// ignore_for_file: avoid_print

import 'package:biomovil/menu_desplegable.dart';
import 'package:flutter/material.dart';
import 'menu_desplegable.dart' as menu;
import 'package:biomovil/animales_tropicales.dart';
import 'package:biomovil/animales_desierto.dart';
import 'package:biomovil/animales_sabana.dart';

class MenuHabitats extends StatelessWidget {
  final List<TropicalCardData> cardData = [
    TropicalCardData(
        "Tropical", "assets/animales/tropical/tropical_habitat.jpg"),
    TropicalCardData("Desierto", "assets/animales/desierto/desierto.jpg"),
    TropicalCardData("Sabana", "assets/animales/sabana/sabana.jpg"),
  ];

  final List<String> menuItems = [
    "Pagina principal",
    "Animales",
    "Codigo QR",
    "Recorridos",
    "Ajustes",
  ];

  final String selectedMenuItem;

  MenuHabitats({Key? key})
      : selectedMenuItem = "Animales",
        super(key: key);

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
          title: Text(
            selectedMenuItem,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return MyDropdownMenu(
                items: menuItems,
                selectedItem: selectedMenuItem,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    print("Item seleccionado: $newValue");
                  }
                },
              );
            },
          ),
        ),
        drawer: menu.MyDrawerMenu(
          items: menuItems,
          onChanged: (String? newValue) {
            if (newValue != null) {
              print("Item seleccionado en el cajón: $newValue");
            }
          },
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                const Text(
                  "Selecciona un hábitat:",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                ...cardData.map((data) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (data.habitat == "Tropical") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AnimalesTropicales()),
                          );
                        } else if (data.habitat == "Desierto") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AnimalesDesierto()),
                          );
                        } else if (data.habitat == "Sabana") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AnimalesSabana()),
                          );
                        }
                      },
                      child: AnimalCard(data: data),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TropicalCardData {
  final String habitat;
  final String imagePath;

  TropicalCardData(this.habitat, this.imagePath);
}

class AnimalCard extends StatefulWidget {
  final TropicalCardData data;

  const AnimalCard({Key? key, required this.data}) : super(key: key);

  @override
  _AnimalCardState createState() => _AnimalCardState();
}

class _AnimalCardState extends State<AnimalCard> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isTapped = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isTapped = false;
        });
      },
      child: InkWell(
        onTap: () {
          if (widget.data.habitat == "Tropical") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AnimalesTropicales()),
            );
          } else if (widget.data.habitat == "Desierto") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AnimalesDesierto()),
            );
          } else if (widget.data.habitat == "Sabana") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AnimalesSabana()),
            );
          }
        },
        child: Card(
          elevation: _isTapped ? 8.0 : 4.0,
          margin: const EdgeInsets.all(8.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: _isTapped
                      ? const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5)
                      : Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.data.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.data.habitat,
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
