import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GeneradorQR extends StatelessWidget {
  const GeneradorQR({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Generador de QR'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              QrImageView(
                data: '/articulo-#-titulo',
                version: QrVersions.auto,
                size: 200.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
