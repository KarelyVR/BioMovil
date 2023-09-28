// ignore_for_file: library_private_types_in_public_api

import 'package:biomovil/pantalla_ajustes/ayuda.dart';
import 'package:biomovil/pantalla_ajustes/comentarios.dart';
import 'package:biomovil/pantalla_ajustes/terminos_condiciones.dart';
import 'package:biomovil/principal/pagina_principal.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Ajustes(),
  ));
}

class Ajustes extends StatefulWidget {
  const Ajustes({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Ajustes> {
  bool notificationsEnabled = false;
  bool locationAccessEnabled = false;
  bool darkModeEnabled = false;

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
            'Ajustes',
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
        ),
        body: Column(
          children: [
            const SizedBox(height: 16.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView(
                  children: [
                    ListTile(
                      title: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 50.0),
                            child: Text(
                              'Notificaciones',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Switch(
                            value: notificationsEnabled,
                            onChanged: (value) {
                              setState(() {
                                notificationsEnabled = value;
                              });
                            },
                            activeColor: Colors.green,
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 194, 189, 189),
                      thickness: 2.0,
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: Text(
                              'Acceso a ubicación',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Switch(
                            value: locationAccessEnabled,
                            onChanged: (value) {
                              setState(() {
                                locationAccessEnabled = value;
                              });
                            },
                            activeColor: Colors.green,
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 194, 189, 189),
                      thickness: 2.0,
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: Text(
                              'Modo oscuro',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Switch(
                            value: darkModeEnabled,
                            onChanged: (value) {
                              setState(() {
                                darkModeEnabled = value;
                              });
                            },
                            activeColor: Colors.green,
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 194, 189, 189),
                      thickness: 2.0,
                    ),
                    ListTile(
                      title: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: Text(
                              'Comentarios o sugerencias',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Comentarios(),
                          ),
                        );
                      },
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 194, 189, 189),
                      thickness: 2.0,
                    ),
                    ListTile(
                      title: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: Text(
                              'Ayuda',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Ayuda(),
                          ),
                        );
                      },
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 194, 189, 189),
                      thickness: 2.0,
                    ),
                    ListTile(
                      title: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: Text(
                              'Términos y condiciones',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TerminosCondiciones(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Contáctanos:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialMediaIcon(
                        icon: Icons.facebook,
                        iconColor: Colors.blue,
                        label: 'Bioparque',
                      ),
                      SizedBox(width: 15.0),
                      SocialMediaIcon(
                        icon: Icons.phone,
                        label: '55 5089 9990',
                        iconColor: Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SocialMediaIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;

  const SocialMediaIcon(
      {super.key, required this.icon, required this.label, this.iconColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        const SizedBox(height: 4.0),
        Text(label),
      ],
    );
  }
}
