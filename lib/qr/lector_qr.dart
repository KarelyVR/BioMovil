import 'package:biomovil/articulos/e_renovable.dart';
import 'package:biomovil/articulos/marpol.dart';
import 'package:biomovil/articulos/panda.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:ui';

import 'package:biomovil/articulos/pangolin.dart';
import 'package:biomovil/articulos/pez_matusalen.dart';
import 'package:biomovil/articulos/tarantula.dart';
import 'package:biomovil/principal/pagina_principal.dart';
import 'package:biomovil/animales/menu_desplegable.dart' as menu;

class LectorCQR extends StatelessWidget {
  final FluroRouter router = FluroRouter();

  LectorCQR({Key? key}) {
    configureRoutes();
  }

  void configureRoutes() {
    router.define(
      '/articulo-1-pangolin',
      handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
            Pangolin(),
      ),
    );

    router.define(
      '/articulo-2-matusalem',
      handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
            PezMatusalem(),
      ),
    );

    router.define(
      '/articulo-3-tarantula',
      handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
            Tarantula(),
      ),
    );

    router.define(
      '/articulo-4-panda',
      handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
            Panda(),
      ),
    );

    router.define(
      '/articulo-5-contaminacion',
      handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
            Contaminacion(),
      ),
    );

    router.define(
      '/articulo-6-erenovables',
      handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
            Renovables(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: router.generator,
      home: const QRScreen(),
    );
  }
}

class QRScreen extends StatefulWidget {
  const QRScreen({Key? key}) : super(key: key);

  @override
  _QRScreenState createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  bool isScanned = false;
  String scannedData = '';

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
          'Escáner QR',
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
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Contenedor oscurecido
                Container(
                  color: Colors.black,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.black.withOpacity(1.0),
                    ),
                  ),
                ),
                // Vista de la cámara
                QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
                // Recuadro del escáner
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white.withOpacity(1.0),
                      width: 3,
                    ),
                  ),
                  width: 200,
                  height: 200,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
      controller.scannedDataStream.listen((scanData) {
        if (!isScanned) {
          setState(() {
            isScanned = true;
            scannedData = scanData.code!;
            if (isValidQR(scannedData)) {
              _showAlertDialog(context);
            } else {
              _showErrorAlertDialog(context);
            }
          });
        }
      });
    });
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Escaneado Correctamente'),
          content: Text('Dirígete a: $scannedData'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _navigateToScreen(context, scannedData);
              },
              child: const Text('Ir'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('QR no válido o no reconocido'),
          actions: [
            TextButton(
              onPressed: () {
                _resetScan();
                Navigator.pop(context);
              },
              child: const Text('Volver a escanear'),
            ),
          ],
        );
      },
    );
  }

  void _resetScan() {
    setState(() {
      isScanned = false;
      scannedData = '';
    });
    controller.resumeCamera();
  }

  void _navigateToScreen(BuildContext context, String scannedData) {
    if (scannedData == '/articulo-1-pangolin') {
      LectorCQR().router.navigateTo(context, scannedData, replace: true);
    } else if (scannedData == '/articulo-2-matusalem') {
      LectorCQR().router.navigateTo(context, scannedData, replace: true);
    } else if (scannedData == '/articulo-3-tarantula') {
      LectorCQR().router.navigateTo(context, scannedData, replace: true);
    }else if (scannedData == '/articulo-4-panda') {
      LectorCQR().router.navigateTo(context, scannedData, replace: true);
    }else if (scannedData == '/articulo-5-contaminacion') {
      LectorCQR().router.navigateTo(context, scannedData, replace: true);
    }else if (scannedData == '/articulo-6-erenovables') {
      LectorCQR().router.navigateTo(context, scannedData, replace: true);
    }else {
      _showErrorAlertDialog(context);
    }
  }

  bool isValidQR(String qrData) {
    if (qrData.length > 35) {
      return false;
    } else if (qrData.toLowerCase().contains('http')) {
      return false;
    }
    return qrData.isNotEmpty;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}