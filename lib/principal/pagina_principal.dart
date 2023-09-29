// ignore_for_file: library_private_types_in_public_api

import 'package:biomovil/articulos/menu_articulos.dart';
import 'package:biomovil/pantalla_ajustes/ajustes.dart';
import 'package:flutter/material.dart';
import 'package:biomovil/animales/menu_habitats.dart';
import 'package:biomovil/principal/galeria_imagenes.dart';
import 'package:biomovil/principal/itinerario.dart';
import 'package:biomovil/recorridos/recorridos_ubicacion.dart';
import 'package:biomovil/lector_qr.dart';


void main() {
  runApp(const PaginaPrincipal());
}

class PaginaPrincipal extends StatelessWidget {
  const PaginaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainScreen(),
      routes: {
        '/menu_habitats': (context) => MenuHabitats(),
        '/recorridos_ubicacion': (context) => const Recorridos(),
        '/galeria_imagenes': (context) => const Galeria(),
        '/lector_qr': (context) => const LectorCQR(),
        '/menu_articulos': (context) =>  MenuArticulos(),
        '/itinerario': (context) => Itinerario(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final int _currentIndex = 0;

  static final List<Widget> _screens = [
    const PantallaInicioWidget(),
    MenuHabitats(),
    const Text('Ubicación de Animales'), // Reemplaza esto con tu contenido
    const Recorridos(), // Reemplaza esto con tu contenido
    const Galeria(), // Reemplaza esto con tu contenido
    Itinerario(),
    MenuArticulos(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
    );
  }
}

class PantallaInicioWidget extends StatelessWidget {
  const PantallaInicioWidget({super.key});

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
          'Inicio',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Ajustes(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: const Icon(
                Icons.settings,
                size: 28,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/bioparque.png', width: 100, height: 100),
                  const SizedBox(width: 10), // Espacio entre la imagen y el texto
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Selecciona cualquier opción',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'para comenzar la aventura',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                ],
              ),
               //caja de boton de menu habitats
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: FractionallySizedBox(
                      widthFactor: 0.8,
                      child: SizedBox(
                        height: 60.0, 
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/menu_habitats');
                          },
                          style: ButtonStyle(
                            alignment: Alignment.center,
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Conoce a los animales',
                                style: TextStyle(color: Colors.black,fontSize: 17),
                              ),
                              Icon(
                                Icons.pets,
                                size: 50,
                                color: Colors.black, // Color del icono
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //caja de boton de escanear QR
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: FractionallySizedBox(
                      widthFactor: 0.8,
                      child: SizedBox(
                        height: 60.0, // Cambia la altura del botón aquí
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/lector_qr');
                          },
                          style: ButtonStyle(
                            alignment: Alignment.center,
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.qr_code,
                                size: 50,
                                color: Colors.black, // Color del icono
                              ),
                              Text(
                                'Escanear QR',
                                style: TextStyle(color: Colors.black,fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
               //caja de boton de recorridos
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: FractionallySizedBox(
                      widthFactor: 0.8,
                      child: SizedBox(
                        height: 60.0, // Cambia la altura del botón aquí
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/recorridos_ubicacion');
                          },
                          style: ButtonStyle(
                            alignment: Alignment.center,
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Recorridos personalizados',
                                style: TextStyle(color: Colors.black,fontSize: 17),
                              ),
                              Icon(
                                Icons.map,
                                size: 50,
                                color: Colors.black, // Color del icono
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
               //caja de boton del itinerario
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: FractionallySizedBox(
                      widthFactor: 0.8,
                      child: SizedBox(
                        height: 60.0, // Cambia la altura del botón aquí
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/itinerario');
                          },
                          style: ButtonStyle(
                            alignment: Alignment.center,
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.calendar_month,
                                size: 50,
                                color: Colors.black, // Color del icono
                              ),
                              Text(
                                'Consulta el itinerario',
                                style: TextStyle(color: Colors.black,fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
               //caja de boton explorar articulos
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0), // Ajusta el margen horizontal aquí
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Alinea los botones al principio y al final
                  children: [
                    Expanded(
                      child: FractionallySizedBox(
                        widthFactor: 1,
                        child: SizedBox(
                          height: 60.0, // Cambia la altura del botón aquí
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/galeria_imagenes');
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                            ),
                            child: const Text(
                              textAlign: TextAlign.center,
                              'Explora los articulos',
                              style: TextStyle(color: Colors.black,
                              fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                     //caja de boton de más informacion
                    const SizedBox(width: 20.0), // Espacio horizontal entre los botones
                    Expanded(
                      child: FractionallySizedBox(
                        widthFactor: 1,
                        child: SizedBox(
                          height: 60.0, // Cambia la altura del botón aquí
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/menu_articulos');
                            },
                            style: ButtonStyle(
                              alignment: Alignment.center,
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                            ),
                            child: const Text(
                              
                              textAlign: TextAlign.center,
                              'Mas \ninformación',
                              style: TextStyle(color: Colors.black,
                              fontSize: 17,
                            ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: _carrusel(),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _carrusel(){
    return Container();//AQUI VA LA PROGRAMACION DEL CARRUSEL
  }
}