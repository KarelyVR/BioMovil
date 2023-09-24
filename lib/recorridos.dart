// ignore_for_file: avoid_print

import 'package:biomovil/menu_desplegable.dart';
import 'package:flutter/material.dart';
import 'menu_desplegable.dart' as menu;

class Recorridos extends StatelessWidget {
  final List<String> menuItems = [
    "Pagina principal",
    "Animales",
    "Codigo QR",
    "Recorridos",
    "Ajustes",
  ];

  final String selectedMenuItem;

  Recorridos({Key? key})
      : selectedMenuItem = "Recorridos",
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
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Selecciona un hábitat:",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}