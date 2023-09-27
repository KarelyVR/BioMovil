import 'package:flutter/material.dart';
import 'package:biomovil/animales/menu_habitats.dart';
import 'package:biomovil/principal/galeria_imagenes.dart';
import 'package:biomovil/recorridos/recorridos_ubicacion.dart';
import 'package:biomovil/lector_qr.dart';

class PaginaPrincipal extends StatelessWidget {
  const PaginaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainScreen(),
      routes: {
        '/menu_habitats': (context) => MenuHabitats(),
        '/recorridos_ubicacion': (context) => const Recorridos(),
        '/galeria_imagenes':(context) => const Galeria(),
        '/lector_qr':(context) => const LectorQR(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class PantallaInicioWidget extends StatelessWidget {
  const PantallaInicioWidget({super.key});

  @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Pantalla Principal'),
          backgroundColor: Colors.green,
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/bioparque.png', width: 150, height: 150),

          const Text(
            'Te damos la bienvenida',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Al bioparque estrella,',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'el hogar de los animales',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          const Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.access_time,
                size: 30.0,
              ),
              SizedBox(width: 10),
              Text('9:00 am - 6:00pm'),
            ],
          ),
          const Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.gps_fixed,
                size: 30.0,
              ),
              SizedBox(width: 10),
              Text('Montemorelos, N.L, México'),
            ],
          ),
        ],
      ),
    ),
    );
  }
}


class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  static final List<Widget> _screens = [
    PantallaInicioWidget(),
    MenuHabitats(),
    const Text('Ubicación de Animales'), // Reemplaza esto con tu contenido
    const Recorridos(), // Reemplaza esto con tu contenido
    const Galeria(), // Reemplaza esto con tu contenido
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.green,
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green,
            icon: Icon(Icons.category),
            label: 'Habitat',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green,
            icon: Icon(Icons.place),
            label: 'Ubicación',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green,
            icon: Icon(Icons.directions_walk),
            label: 'Recorridos',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green,
            icon: Icon(Icons.photo),
            label: 'Galería',
          ),
        ],
      ),
    );
  }
}
