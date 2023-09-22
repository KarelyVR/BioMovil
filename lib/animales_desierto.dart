import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
    TropicalCardData("Camello", "assets/camello.jpg"),
    TropicalCardData("Coyote", "assets/coyote.jpg"),
    TropicalCardData("Serpiente de cascabel", "assets/serpiente_cascabel.jpg"),
    TropicalCardData("Liebre", "assets/liebre.jpeg"),
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
              color: Colors.black,
            ),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
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
                  return AnimalCard(data: filteredCardData[index]);
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
              animal.habitat.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    });
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

class MyDrawerMenu extends StatelessWidget {
  final List<String> items;
  final ValueChanged<String?> onChanged;

  MyDrawerMenu({
    required this.items,
    required this.onChanged,
  });

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
