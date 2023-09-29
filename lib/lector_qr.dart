// ignore_for_file: unused_import, avoid_print

import 'package:flutter/material.dart';
import 'package:biomovil/animales/menu_desplegable.dart';
import 'package:biomovil/animales/menu_desplegable.dart' as menu;
import 'package:biomovil/articulos/menu_articulos.dart';
import 'package:biomovil/lector_qr.dart';
import 'package:biomovil/lector_qr.dart' as scan;
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:biomovil/principal/pagina_principal.dart';

class LectorCQR extends StatelessWidget {
  const LectorCQR({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LectorQR(),
      routes: {
        '/menu_articulos': (context) =>  MenuArticulos(),
      },
    );
  }
}

class LectorQR extends StatefulWidget {
  const LectorQR({Key? key}) : super(key: key);

  @override
  State<LectorQR> createState() => _LectorQRState();
}

class _LectorQRState extends State<LectorQR>{
  
  //late String scannedMsg= "Enfoque el código QR dentro del recuadro";
  //TextEditingController controller = TextEditingController();
  final List<String> menuItems = [
    "Pagina principal",
    "Animales",
    "Codigo QR",
    "Ubicacion",
    "Ajustes",
  ];

  String selectedMenuItem = "Lector QR";
  final TextEditingController searchController = TextEditingController();
  
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        
      appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0,
          centerTitle: true,
          //title: const Text('Lector QR'),

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
                builder: (context) =>  const PaginaPrincipal(),
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
      
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/articulos/imagenqr.png', width: 300, height: 300),
          
                                     
        /*
         ElevatedButton(
          onPressed: () {
            //scanQr(); Aqui se pone la direccion a donde va a mandar el boton a la linea de articulos
            Navigator.pushNamed(context, '/menu_articulos');
          },
            style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 37, 136, 202),
            ),
            child: const Text('Ir a articulos'), //Boton que manda a articulos
            
            ),
            */
            const SizedBox(height: 20),
            //Text(scannedMsg),

            ElevatedButton(
                onPressed: () {
                  // Mostrar la alerta al presionar el botón "Mostrar Alerta"
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Alerta'),
                        content: const Text('No disponible por el momento.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // Cerrar la alerta al presionar el botón "OK"
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Scanear'),
              ),

              /*
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
 
                  Expanded(
                    child: FractionallySizedBox(
                      widthFactor: 0.3,
                      child: SizedBox(
                        
                        height: 40.0, // Cambia la altura del botón aquí
                        child: ElevatedButton(
                          
                          onPressed: () {
                            //Navigator.pushNamed(context, '/menu_articulos');
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>   MenuArticulos()),
                          );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 37, 136, 202),
                            ),
                            child: const Text('Ir a articulos'), //Boton que manda a articulos
                        ),
                      ),
                    ),
                  ),
                ],
              ),*/

           ],
          ),
        ),
      ),
     ),
    );
  }
  /*
  void scanQr() async{

    String? scanResult = await scanner.scan();
    scannedMsg = scanResult.toString();
    setState(() {
         
    });
    
  }*/

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
