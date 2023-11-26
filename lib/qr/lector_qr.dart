import 'package:biomovil/articulos/pangolin.dart';
import 'package:biomovil/articulos/pez_matusalen.dart';
import 'package:biomovil/articulos/tarantula.dart';
import 'package:biomovil/principal/pagina_principal.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:biomovil/animales/menu_desplegable.dart' as menu;


class LectorCQR extends StatelessWidget {
  final FluroRouter router = FluroRouter();

  LectorCQR({super.key}) {
    configureRoutes();
  }

  void configureRoutes() {
    router.define(
      '/articulo-1-pangolin',
      handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, dynamic> params) => Pangolin(),
      ),
    );

    router.define(
      '/articulo-2-matusalem',
      handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, dynamic> params) => PezMatusalem(),
      ),
    );

    router.define(
      '/articulo-3-tarantula',
      handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, dynamic> params) => Tarantula(),
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
  final List<String> menuItems = [
    "Pagina principal",
    "Animales",
    "Codigo QR",
    "Recorridos",
    "Ajustes",
  ];
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
          'Escaner QR',
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
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
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
          content: Text('Dirigirse a: $scannedData'),
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
    } else {
      _showErrorAlertDialog(context);
    }
  }

  bool isValidQR(String qrData) {
    if (qrData.length > 35) {
      return false;
    }else if (qrData.toLowerCase().contains('http')) {
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

