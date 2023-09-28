// ignore_for_file: avoid_print

import 'package:biomovil/principal/pagina_principal.dart';
import 'package:flutter/material.dart';
import 'package:biomovil/animales/menu_desplegable.dart' as menu;

Widget buildImageCell(String imagePath) {
  return Container(
    margin: const EdgeInsets.all(8.0), // Margen entre las celdas de imagen
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0), // Borde redondeado
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5), // Sombra
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover, // Ajusta la imagen al tamaño de la celda
      ),
    ),
  );
}


class Itinerario extends StatelessWidget {
  Itinerario({super.key});
  final List<String> menuItems = [
    "Pagina principal",
    "Animales",
    "Codigo QR",
    "Recorridos",
    "Ajustes",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Crea tu recorrido',
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
      drawer: menu.MyDrawerMenu(
          items: menuItems,
          onChanged: (String? newValue) {
            if (newValue != null) {
              print("Item seleccionado en el cajón: $newValue");
            }
          },
        ),
      body: const SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Text(
                'Lunes a viernes',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Safari',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.access_time_outlined), // Agrega aquí el icono que desees
                        SizedBox(width: 8), // Añade un espacio entre el icono y el texto
                        Text(
                          '9:00 am - 10:00 am',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Show de animales',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.access_time_outlined), // Agrega aquí el icono que desees
                        SizedBox(width: 8), // Añade un espacio entre el icono y el texto
                        Text(
                          '10:00 am - 12:00 pm',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Safari',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.access_time_outlined), // Agrega aquí el icono que desees
                        SizedBox(width: 8), // Añade un espacio entre el icono y el texto
                        Text(
                          '2:00 pm - 3:00 pm',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Show de animales',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.access_time_outlined), // Agrega aquí el icono que desees
                        SizedBox(width: 8), // Añade un espacio entre el icono y el texto
                        Text(
                          '3:00 pm - 5:00 pm',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20,),
              Text(
                'Sábado',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Safari',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.access_time_outlined), // Agrega aquí el icono que desees
                        SizedBox(width: 8), // Añade un espacio entre el icono y el texto
                        Text(
                          '9:00 am - 10:00 am',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Show de animales',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.access_time_outlined), // Agrega aquí el icono que desees
                        SizedBox(width: 8), // Añade un espacio entre el icono y el texto
                        Text(
                          '10:00 am - 12:00 pm',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Safari',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.access_time_outlined), // Agrega aquí el icono que desees
                        SizedBox(width: 8), // Añade un espacio entre el icono y el texto
                        Text(
                          '2:00 pm - 3:00 pm',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Show de animales',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.access_time_outlined), // Agrega aquí el icono que desees
                        SizedBox(width: 8), // Añade un espacio entre el icono y el texto
                        Text(
                          '3:00 pm - 5:00 pm',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Text(
                'Domingo',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Safari',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.access_time_outlined), // Agrega aquí el icono que desees
                        SizedBox(width: 8), // Añade un espacio entre el icono y el texto
                        Text(
                          '9:00 am - 10:00 am',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Show de animales',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.access_time_outlined), // Agrega aquí el icono que desees
                        SizedBox(width: 8), // Añade un espacio entre el icono y el texto
                        Text(
                          '10:00 am - 12:00 pm',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Safari',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.access_time_outlined), // Agrega aquí el icono que desees
                        SizedBox(width: 8), // Añade un espacio entre el icono y el texto
                        Text(
                          '2:00 pm - 3:00 pm',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Show de animales',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.access_time_outlined), // Agrega aquí el icono que desees
                        SizedBox(width: 8), // Añade un espacio entre el icono y el texto
                        Text(
                          '3:00 pm - 5:00 pm',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}



