// ignore_for_file: avoid_print

import 'package:biomovil/articulos/pangolin.dart';
import 'package:biomovil/articulos/pez_matusalen.dart';
import 'package:biomovil/articulos/tarantula.dart';
import 'package:biomovil/principal/pagina_principal.dart';
import 'package:flutter/material.dart';
import 'package:biomovil/animales/menu_desplegable.dart' as menu;


class MenuArticulos extends StatelessWidget {

  final List<ArticulosCardData> cardData = [
    ArticulosCardData("Pangolin", "assets/articulos/pangolin.jpg"),
    ArticulosCardData("Pez", "assets/articulos/pez.jpg"),
    ArticulosCardData("Tarantula", "assets/articulos/tarantula.jpg"),
    
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
                const SizedBox(height: 40.0),
                ...cardData.map((data) {
                  return GestureDetector(
                    onTap: () {
                      if (data.habitat == "Pangolin") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  Pangolin()),
                        );
                      } else if (data.habitat == "Pez") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  PezMatusalem()),
                        );
                      } else if (data.habitat == "Tarantula") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  Tarantula()),
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
