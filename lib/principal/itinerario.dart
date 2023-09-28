import 'package:flutter/material.dart';

Widget buildImageCell(String imagePath) {
  return Container(
    margin: const EdgeInsets.all(8.0), // Margen entre las celdas de imagen
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0), // Borde redondeado
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5), // Sombra
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover, // Ajusta la imagen al tamaño de la celda
      ),
    ),
  );
}


class Itinerario extends StatelessWidget {
  const Itinerario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Itinerario'),
        backgroundColor: Colors.green,
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Text(
                'Lunes a viernes',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Safari',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.access_time_outlined), // Agrega aquí el icono que desees
                        SizedBox(width: 8), // Añade un espacio entre el icono y el texto
                        Text(
                          '9:00 am - 10:00 am',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Show de animales',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.access_time_outlined), // Agrega aquí el icono que desees
                        SizedBox(width: 8), // Añade un espacio entre el icono y el texto
                        Text(
                          '10:00 am - 12:00 pm',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Safari',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.access_time_outlined), // Agrega aquí el icono que desees
                        SizedBox(width: 8), // Añade un espacio entre el icono y el texto
                        Text(
                          '2:00 pm - 3:00 pm',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Show de animales',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.access_time_outlined), // Agrega aquí el icono que desees
                        SizedBox(width: 8), // Añade un espacio entre el icono y el texto
                        Text(
                          '3:00 pm - 5:00 pm',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20,),
              Text(
                'Sábado',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Safari',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.access_time_outlined), // Agrega aquí el icono que desees
                        SizedBox(width: 8), // Añade un espacio entre el icono y el texto
                        Text(
                          '9:00 am - 10:00 am',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Show de animales',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.access_time_outlined), // Agrega aquí el icono que desees
                        SizedBox(width: 8), // Añade un espacio entre el icono y el texto
                        Text(
                          '10:00 am - 12:00 pm',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Safari',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.access_time_outlined), // Agrega aquí el icono que desees
                        SizedBox(width: 8), // Añade un espacio entre el icono y el texto
                        Text(
                          '2:00 pm - 3:00 pm',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Show de animales',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.access_time_outlined), // Agrega aquí el icono que desees
                        SizedBox(width: 8), // Añade un espacio entre el icono y el texto
                        Text(
                          '3:00 pm - 5:00 pm',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Text(
                'Domingo',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Safari',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.access_time_outlined), // Agrega aquí el icono que desees
                        SizedBox(width: 8), // Añade un espacio entre el icono y el texto
                        Text(
                          '9:00 am - 10:00 am',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Show de animales',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.access_time_outlined), // Agrega aquí el icono que desees
                        SizedBox(width: 8), // Añade un espacio entre el icono y el texto
                        Text(
                          '10:00 am - 12:00 pm',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Safari',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.access_time_outlined), // Agrega aquí el icono que desees
                        SizedBox(width: 8), // Añade un espacio entre el icono y el texto
                        Text(
                          '2:00 pm - 3:00 pm',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Show de animales',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.access_time_outlined), // Agrega aquí el icono que desees
                        SizedBox(width: 8), // Añade un espacio entre el icono y el texto
                        Text(
                          '3:00 pm - 5:00 pm',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}



