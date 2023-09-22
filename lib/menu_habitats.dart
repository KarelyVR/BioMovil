import 'package:flutter/material.dart';
import 'menu_desplegable.dart';
import 'animales_tropicales.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<TropicalCardData> cardData = [
    TropicalCardData("Tropical", "assets/tropical_habitat.jpg"),
    TropicalCardData("Desierto", "assets/desierto_habitat.jpg"),
    TropicalCardData("Sabana", "assets/sabana_habitat.jpg"),
  ];

  final List<String> menuItems = [
    "Pagina principal",
    "Animales",
    "Codigo QR",
    "Ubicacion",
    "Ajustes",
  ];

  final String selectedMenuItem;

  MyApp({Key? key})
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
                  if (newValue != null) {}
                },
              );
            },
          ),
        ),
        drawer: MyDrawerMenu(
          items: menuItems,
          onChanged: (String? newValue) {
            if (newValue != null) {}
          },
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                const Text(
                  "Selecciona un Hábitat:",
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyAppAnimalesTropicales()),
                        );
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

class AnimalCard extends StatelessWidget {
  final TropicalCardData data;

  AnimalCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(data.imagePath),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0),
            ),
            child: Center(
              child: Text(
                data.habitat,
                style: const TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
