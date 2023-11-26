import 'package:biomovil/animales/habitat_tropical/mandrill.dart';
import 'package:biomovil/animales/habitat_tropical/puma.dart';
import 'package:biomovil/animales/habitat_tropical/tigre.dart';
import 'package:biomovil/animales/habitat_tropical/tucan.dart';
import 'package:biomovil/animales/menu_habitats.dart';
import 'package:flutter/material.dart';
import 'package:biomovil/animales/menu_desplegable.dart' as menu;

class AnimalesTropicales extends StatefulWidget {
  const AnimalesTropicales({super.key});

  @override
  State<AnimalesTropicales> createState() => _AnimalesTropicales();
}

class _AnimalesTropicales extends State<AnimalesTropicales> {
  final List<String> menuItems = [
    "Pagina principal",
    "Animales",
    "Codigo QR",
    "Ubicacion",
    "Ajustes",
  ];

  String selectedMenuItem = "Tropical";
  final TextEditingController searchController = TextEditingController();

  final List<TropicalCardData> cardData = [
    TropicalCardData("Tucan", "assets/animales/tropical/tucan.jpg"),
    TropicalCardData("Mandrill", "assets/animales/tropical/mandrill.jpg"),
    TropicalCardData("Puma", "assets/animales/tropical/puma.jpg"),
    TropicalCardData("Tigre", "assets/animales/tropical/tigre.jpg"),
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
                      if (data.animalIndex == "Tucan") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Tucan()),
                        );
                      } else if (data.animalIndex == "Mandrill") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Mandrill()),
                        );
                      } else if (data.animalIndex == "Tigre") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Tigre()),
                        );
                      } else if (data.animalIndex == "Puma") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Puma()),
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
