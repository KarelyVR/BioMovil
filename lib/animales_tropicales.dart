import 'package:flutter/material.dart';

void main() {
  runApp(MyAppAnimalesTropicales());
}

class MyAppAnimalesTropicales extends StatelessWidget {
  final List<TropicalCardData> cardData = [
    TropicalCardData("Túcan", "assets/tucan.jpg"),
    TropicalCardData("Mandrill", "assets/mandrill.jpg"),
    TropicalCardData("Puma", "assets/puma.jpg"),
    TropicalCardData("Tigre", "assets/tigre.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: GreenAppBar(
          title: "Animales",
          titleColor: Colors.black,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar por nombre',
                  prefixIcon: Icon(Icons.search),
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
                itemCount: cardData.length,
                itemBuilder: (BuildContext context, int index) {
                  return AnimalCard(data: cardData[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color titleColor;

  GreenAppBar({required this.title, this.titleColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
        title,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: titleColor,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
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
