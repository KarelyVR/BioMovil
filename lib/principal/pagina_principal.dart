import 'package:flutter/material.dart';
import 'package:biomovil/animales/menu_habitats.dart';
import 'package:biomovil/principal/galeria_imagenes.dart';
import 'package:biomovil/principal/itinerario.dart';
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
        '/galeria_imagenes': (context) => const Galeria(),
        '/lector_qr': (context) => const LectorQR(),
        '/itinerario': (context) => const Itinerario(),
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
  int _currentIndex = 0;

  static final List<Widget> _screens = [
    const PantallaInicioWidget(),
    MenuHabitats(),
    const Text('Ubicación de Animales'), // Reemplaza esto con tu contenido
    const Recorridos(), // Reemplaza esto con tu contenido
    const Galeria(), // Reemplaza esto con tu contenido
    const Itinerario(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      // Dejo esto como comentario porque a lo mejor nos puede llegar a servir en un futuro
      // Además que si quitaba todo el código explotaba la app

      /*bottomNavigationBar: BottomNavigationBar(
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
      ),*/
    );
  }
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
                            Navigator.pushNamed(context, '/menu_habitats');
                          },
                          style: ButtonStyle(
                            alignment: Alignment.center,
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.qr_code,
                                color: Colors.black, // Color del icono
                              ),
                              SizedBox(width: 8.0), // Espacio entre el icono y el texto
                              Text(
                                'Conoce a los animales',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.qr_code,
                                color: Colors.black, // Color del icono
                              ),
                              SizedBox(width: 8.0), // Espacio entre el icono y el texto
                              Text(
                                'Escanear QR',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),


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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.map,
                                color: Colors.black, // Color del icono
                              ),
                              SizedBox(width: 8.0), // Espacio entre el icono y el texto
                              Text(
                                'Recorridos personalizados',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),


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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: Colors.black, // Color del icono
                              ),
                              SizedBox(width: 8.0), // Espacio entre el icono y el texto
                              Text(
                                'Consulta el itinerario',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

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
                              alignment: Alignment.center,
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                            ),
                            child: const Text(
                              'Explora la galeria',
                              style: TextStyle(color: Colors.black,
                              fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20.0), // Espacio horizontal entre los botones
                    Expanded(
                      child: FractionallySizedBox(
                        widthFactor: 1,
                        child: SizedBox(
                          height: 60.0, // Cambia la altura del botón aquí
                          child: ElevatedButton(
                            onPressed: () {
                              _cambiarPantalla(context, 2); // Cambia al índice del botón 2
                              // Esta pantalla no existe, por eso no le puse nada
                            },
                            style: ButtonStyle(
                              alignment: Alignment.center,
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                            ),
                            child: const Text(
                              'Mas información',
                              style: TextStyle(color: Colors.black,
                              fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),






            ],
          ),
        ),
      ),
    );
  }

  void _cambiarPantalla(BuildContext context, int index) {
    // Implementa aquí la lógica para cambiar de pantalla
  }
}

void main() {
  runApp(const PaginaPrincipal());
}
