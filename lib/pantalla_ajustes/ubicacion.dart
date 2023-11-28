// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Ubicacion extends StatefulWidget {
  const Ubicacion({super.key});

  @override
  _UbicacionState createState() => _UbicacionState();
}

class _UbicacionState extends State<Ubicacion> {
  ValueNotifier<bool> locationAccessEnabled = ValueNotifier<bool>(false);

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("error");
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  // Variable en la clase _UbicacionState
  Color buttonColor = Colors.green; // Color predeterminado

// En el método getCurrentLocation
  void getCurrentLocation() async {
    Position position = await determinePosition();
    print(position.altitude);
    print(position.latitude);
    setState(() {
      // Cambiar el color del botón si se permite el acceso a la ubicación
      buttonColor = Colors.red; // Cambia el color a lo que desees
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubicación'),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Text(
                  '     Permitir ubicación',
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: getCurrentLocation,
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(buttonColor),
                  ),
                  child: const Text('Permitir'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
            width: 20,
          ),
          Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Column(
              children: [
                Text(
                  'Descubre una experiencia única con solo un toque, permitir el acceso a tu ubicación en nuestra aplicación de bioparque te llevará a un mundo de maravillas naturales. ¿Te gustaría explorar cada rincón de nuestro santuario animal y vegetal sin perderte ni un solo detalle? Con tu ubicación activada, podrás sumergirte en un viaje lleno de descubrimientos y sorpresas.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'No te pierdas la oportunidad de aprovechar al máximo tu tiempo con nosotros. Al activar la ubicación, nos aseguramos de que cada minuto sea memorable, proporcionándote información valiosa y una guía interactiva para que tu experiencia sea inolvidable.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
