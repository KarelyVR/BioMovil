import 'package:flutter/material.dart';

class MyDropdownMenu extends StatelessWidget {
  final List<String> items;
  final String selectedItem;
  final ValueChanged<String?> onChanged;

  MyDropdownMenu({
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
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
        children: items.map((String item) {
          return ListTile(
            title: Text(item),
            onTap: () {
              onChanged(item);
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }
}

void main() {
  runApp(MyAppAnimalesTropicales());
}

class MyAppAnimalesTropicales extends StatefulWidget {
  @override
  _MyAppAnimalesTropicalesState createState() =>
      _MyAppAnimalesTropicalesState();
}

class _MyAppAnimalesTropicalesState extends State<MyAppAnimalesTropicales> {
  final List<TropicalCardData> cardData = [
    TropicalCardData("Túcan", "assets/tucan.jpg"),
    TropicalCardData("Mandrill", "assets/mandrill.jpg"),
    TropicalCardData("Puma", "assets/puma.jpg"),
    TropicalCardData("Tigre", "assets/tigre.jpg"),
  ];

  List<TropicalCardData> filteredCardData = [];

  @override
  void initState() {
    super.initState();
    filteredCardData = List.from(cardData);
  }

  void filterByKeyword(String keyword) {
    setState(() {
      if (keyword.isEmpty) {
        filteredCardData = List.from(cardData);
      } else {
        filteredCardData = cardData
            .where((animal) =>
                animal.habitat.toLowerCase().contains(keyword.toLowerCase()))
            .toList();
      }
    });
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
          title: const Text(
            "Animales",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          leading: MyDropdownMenu(
            items: [
              "Pagina principal",
              "Animales",
              "Codigo QR",
              "Ubicacion",
              "Ajustes",
            ],
            selectedItem:
                "Pagina principal", // Puedes seleccionar el elemento inicial aquí
            onChanged: (String? item) {
              // Lógica para manejar la selección del menú
              print("Item seleccionado: $item");
              // Puedes agregar lógica adicional para manejar la selección aquí
            },
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
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
