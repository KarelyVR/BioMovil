import 'package:flutter/material.dart';
import 'package:biomovil/animales/menu_desplegable.dart';
import 'package:biomovil/lector_qr.dart';
import 'package:biomovil/lector_qr.dart' as scan;
import 'package:qrscan/qrscan.dart' as scanner;


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Enfoque el codigo QR dentro del recuadro'),
        ),
        body: Center(
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
      appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0,
          centerTitle: true,
          title: const Text('Lector QR'),
          //Hasta aqui probar menu y boton salir









      ),
        
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
            backgroundColor: Color.fromARGB(255, 37, 136, 202),
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