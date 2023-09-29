// ignore_for_file: avoid_print, library_private_types_in_public_api
/*
import 'package:biomovil/articulos/pez_matusalen.dart';
import 'package:biomovil/articulos/tarantula.dart';
import 'package:biomovil/articulos/pangolin.dart';
import 'package:flutter/material.dart';
import 'package:biomovil/lector_qr.dart';


class MenuArticulos extends StatefulWidget {
  const MenuArticulos({super.key});

  @override
  State<MenuArticulos> createState() => _MenuArticulos();
}

class _MenuArticulos extends State<MenuArticulos> {
  final List<String> menuItems = [
    "Pagina principal",
    "Animales",
    "Codigo QR",
    "Ubicacion",
    "Ajustes",
  ];

  String selectedMenuItem = "Ultima Noticias";
  final TextEditingController searchController = TextEditingController();

  final List<TropicalCardData> cardData = [
    TropicalCardData("Conservación del pangolín", "assets/articulos/pangolin/pangolin.jpg"),
    TropicalCardData("Conoce al pez más viejo en un acuario", "assets/articulos/pez_matusalem/pez.jpg"),
    TropicalCardData("Descubren en Tailandia una especie de tarántula azul eléctrica", "assets/articulos/tarantula/tarantula.jpg"),
    
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
        
        title: Text(
          selectedMenuItem,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LectorQR(),
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
                      if (data.animalIndex == "Pangolin") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>   Pangolin()),
                        );
                      } else if (data.animalIndex == "Pez_Matusalem") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  PezMatusalem()),
                        );
                      } else if (data.animalIndex == "Tarantula") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  Tarantula()),
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
}*/

//////////////////////////////////////////
///2DO DISEÑO DE PANTALLAS


import 'package:biomovil/animales/menu_desplegable.dart';
import 'package:biomovil/articulos/pangolin.dart';
import 'package:biomovil/articulos/pez_matusalen.dart';
import 'package:biomovil/articulos/tarantula.dart';
import 'package:flutter/material.dart';
import 'package:biomovil/animales/menu_desplegable.dart' as menu;


class MenuArticulos extends StatelessWidget {

  final List<ArticulosCardData> cardData = [
    ArticulosCardData("Conservación del pangolín", "assets/articulos/pangolin.jpg"),
    ArticulosCardData("Conoce al pez más viejo en un acuario", "assets/articulos/pez.jpg"),
    ArticulosCardData("Descubren en Tailandia una especie de tarántula azul eléctrica", "assets/articulos/tarantula.jpg"),
    
  ];

  final List<String> menuItems = [
    "Pagina principal",
    "Animales",
    "Codigo QR",
    "Recorridos",
    "Ajustes",
  ];

  final String selectedMenuItem;

  MenuArticulos({Key? key})
      : selectedMenuItem = "Ultimas noticias",
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
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
               /* const Text(
                  "Selecciona un hábitat:",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),*/
                const SizedBox(height: 20.0),
                ...cardData.map((data) {
                  return GestureDetector(
                    onTap: () {
                      if (data.habitat == "Pangolin") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Pangolin()),
                        );
                      } else if (data.habitat == "Pez") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PezMatusalem()),
                        );
                      } else if (data.habitat == "Tarantula") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Tarantula()),
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

// class _AnimalCardState extends State<AnimalCard> {
//   bool _isTapped = false;

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) {
//         setState(() {
//           _isTapped = true;
//         });
//       },
//       onExit: (_) {
//         setState(() {
//           _isTapped = false;
//         });
//       },
//       child: InkWell(
//         onTap: () {
//           if (widget.data.habitat == "pangolin") {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => const Pangolin()),
//             );
//           } else if (widget.data.habitat == "tarantula") {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const Tarantula()),
//             );
//           } else if (widget.data.habitat == "pez") {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const PezMatusalem()),
//             );
//           }
//         },
//         child: Card(
//           elevation: _isTapped ? 8.0 : 4.0,
//           margin: const EdgeInsets.all(8.0),
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 300),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.0),
//               boxShadow: [
//                 BoxShadow(
//                   color: _isTapped
//                       ? const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5)
//                       : Colors.grey.withOpacity(0.5),
//                   spreadRadius: 1,
//                   blurRadius: 5,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(10.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(widget.data.imagePath),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: Center(
//                   child: Text(
//                     widget.data.habitat,
//                     style: const TextStyle(
//                       fontSize: 30.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
