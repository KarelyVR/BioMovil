// ignore_for_file: unused_import
import 'package:biomovil/animales/menu_desplegable.dart' as menu;
import 'package:biomovil/principal/pagina_principal.dart';
import 'package:flutter/material.dart';
import 'package:biomovil/animales/menu_desplegable.dart';
import 'package:biomovil/lector_qr.dart';
import 'package:biomovil/lector_qr.dart' as scan;
import 'package:qrscan/qrscan.dart' as scanner;

class LectorCodigosQR extends StatelessWidget {
  LectorCodigosQR({super.key});
  final List<String> menuItems = [
    "Pagina principal",
    "Animales",
    "Codigo QR",
    "Recorridos",
    "Ajustes",
  ];


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          'Escanear QR',
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
        body: const Center(
          child: LectorQR(),
        ),
      ),
    );
  }
}

class LectorQR extends StatefulWidget {
  const LectorQR({Key? key}) : super(key: key);

  @override
  State<LectorQR> createState() => _LectorQRState();
}

class _LectorQRState extends State<LectorQR>{
  
  late String scannedMsg= "Enfoque el código QR dentro del recuadro";
  TextEditingController controller = TextEditingController();


  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
        /*
        children: <Widget>[
          
          const SizedBox(height: 40,),

          TextButton(onPressed: (){
            scanQr();

          }, child: const Text("Scanear QR")),

          const SizedBox(height: 50,),
          Text(scannedMsg),
          
        ],*/
        children: <Widget>[
        
         ElevatedButton(
          onPressed: () {
            scanQr();
          },
            style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 37, 136, 202),
            ),
            child: const Text('Scanear QR'),
            
            ),
            const SizedBox(height: 30),
            Text(scannedMsg),
           ],
          ),
        ),
      ),
     ),
    );
  }
  
  void scanQr() async{

    String? scanResult = await scanner.scan();
    scannedMsg = scanResult.toString();
    setState(() {
         
    });
    
  }

}