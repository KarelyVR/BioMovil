import 'package:biomovil/principal/pagina_principal.dart';
import 'package:biomovil/animales/menu_desplegable.dart' as menu;
import 'package:flutter/material.dart';


class MoreInfoScreen extends StatelessWidget {
  MoreInfoScreen({super.key});
  final List<String> menuItems = [
    "Pagina principal",
    "Animales",
    "Codigo QR",
    "Recorridos",
    "Ajustes",
  ];

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
          'Bioparque Estrella',
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
                  // Abre el drawer (menú lateral derecho)
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/bioparque.jpg', 
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Descripción:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              'El Bioparque Estrella es un lugar increíble lleno de vida y naturaleza. '
              'Con una amplia variedad de especies animales y actividades educativas, '
              'es el destino perfecto para disfrutar en familia.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Horario de Operación:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Lunes a Domingo: 9:00 AM - 8:00 PM',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Ubicación:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Montemorelos, Nuevo León, México',
              style: TextStyle(fontSize: 16),
            ),
            // const SizedBox(height: 16.0),
            // ElevatedButton(
            //   onPressed: () {
            //     // Agrega aquí la lógica para abrir un mapa o realizar alguna acción.
            //     // Puedes utilizar plugins como url_launcher para abrir un mapa.
            //   },
            //   child: const Text('Ver en el Mapa'),
            // ),
          ],
        ),
      ),
    );
  }
}
