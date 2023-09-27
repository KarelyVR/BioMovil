import 'package:biomovil/pantalla_ajustes.dart/ayuda.dart';
import 'package:biomovil/pantalla_ajustes.dart/comentarios.dart';
import 'package:biomovil/pantalla_ajustes.dart/terminos_condiciones.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Ajustes(),
  ));
}

class Ajustes extends StatefulWidget {
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
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60.0),
              bottomRight: Radius.circular(60.0),
            ),
          ),
          title: const Center(
            child: Text(
              'Ajustes',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
                            builder: (context) => Comentarios(),
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
                            builder: (context) => Ayuda(),
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
                            builder: (context) => terminosCondiciones(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Contáctanos:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialMediaIcon(
                        icon: Icons.facebook,
                        iconColor: Colors.blue,
                        label: 'Bioparque',
                      ),
                      const SizedBox(width: 15.0),
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

  SocialMediaIcon(
      {required this.icon, required this.label, this.iconColor = Colors.black});

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
