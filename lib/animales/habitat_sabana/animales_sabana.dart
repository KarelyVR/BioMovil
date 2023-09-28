// ignore_for_file: avoid_print

import 'package:biomovil/animales/habitat_sabana/leon.dart';
import 'package:biomovil/animales/habitat_sabana/jirafa.dart';
import 'package:biomovil/animales/habitat_sabana/elefante.dart';
import 'package:biomovil/animales/habitat_sabana/avestruz.dart';
import 'package:biomovil/animales/menu_habitats.dart';
import 'package:flutter/material.dart';

class AnimalesSabana extends StatefulWidget {
  const AnimalesSabana({super.key});

  @override
  State<AnimalesSabana> createState() => _AnimalesTropicales();
}

class _AnimalesTropicales extends State<AnimalesSabana> {
  final List<String> menuItems = [
    "Pagina principal",
    "Animales",
    "Codigo QR",
    "Ubicacion",
    "Ajustes",
  ];

  String selectedMenuItem = "Animales";
  final TextEditingController searchController = TextEditingController();

  final List<TropicalCardData> cardData = [
    TropicalCardData("León", "assets/animales/sabana/leon.jpg"),
    TropicalCardData("Jirafa", "assets/animales/sabana/jirafa.jpg"),
    TropicalCardData("Elefante", "assets/animales/sabana/elefante.jpg"),
    TropicalCardData("Avestruz", "assets/animales/sabana/avestruz.jpg"),
  ];

  List<TropicalCardData> filteredCardData = [];

  @override
  void initState() {
    super.initState();
    filteredCardData = List.from(cardData);
  }

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
            color: Colors.white,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MenuHabitats(),
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
      drawer: MyDrawerMenu(
        items: menuItems,
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              selectedMenuItem = newValue;
            });
            print("Item seleccionado en el cajón: $newValue");
          }
        },
      ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: filterByKeyword,
                decoration: InputDecoration(
                  hintText: 'Buscar por nombre',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: filteredCardData.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = filteredCardData[index];
                  return GestureDetector(
                    onTap: () {
                      if (data.animalIndex == "León") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Leon()),
                        );
                      } else if (data.animalIndex == "Jirafa") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Jirafa()),
                        );
                      } else if (data.animalIndex == "Elefante") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Elefante()),
                        );
                      } else if (data.animalIndex == "Avestruz") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Avestruz()),
                        );
                      }
                    },
                    child: AnimalCard(data: data),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void filterByKeyword(String keyword) {
    setState(() {
      filteredCardData = cardData
          .where((animal) =>
              animal.animalIndex.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    });
  }
}

class TropicalCardData {
  final String animalIndex;
  final String imagePath;

  TropicalCardData(this.animalIndex, this.imagePath);
}

class AnimalCard extends StatelessWidget {
  final TropicalCardData data;

  const AnimalCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(data.imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Text(
              data.animalIndex,
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

class MyDrawerMenu extends StatelessWidget {
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const MyDrawerMenu({
    Key? key,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ...items.map((item) {
            return ListTile(
              title: Text(item),
              onTap: () {
                onChanged(item);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}
