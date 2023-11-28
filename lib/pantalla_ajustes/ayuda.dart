// ignore_for_file: library_private_types_in_public_api

import 'package:biomovil/pantalla_ajustes/ajustes.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() => runApp(const Ayuda());

class Ayuda extends StatelessWidget {
  const Ayuda({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FeedbackScreen(),
    );
  }
}

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {

  Future<void> _onBackPressed() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const Ajustes()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: AppBar(
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
                'Información de la app',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  _onBackPressed();
                },
              ),
            ),
          ),
          body: FutureBuilder(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.hasData) {
                PackageInfo packageInfo = snapshot.data!;
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      item('Nombre de la aplicación', packageInfo.appName),
                      item('Versión de la aplicación', packageInfo.version),
                      item('Número de compilación', packageInfo.buildNumber),
                      item('Nombre del paquete', packageInfo.packageName),
                    ],
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ));
  }

  item(String name, String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
