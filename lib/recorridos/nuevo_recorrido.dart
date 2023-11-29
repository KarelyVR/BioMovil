// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:biomovil/principal/pagina_principal.dart';
import 'package:flutter/material.dart';
import 'package:biomovil/recorridos/polylineas/polilinea1.dart';
import 'package:biomovil/animales/menu_desplegable.dart' as menu;

class SelectionScreen extends StatefulWidget {
  final List<String> initialSelectedAnimals;

  const SelectionScreen({
    Key? key,
    required this.initialSelectedAnimals,
  }) : super(key: key);

  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  List<String> availableZones = ['Tropical', 'Sabana', 'Desierto'];
    String selectedZone = 'Tropical';  // Valor predeterminado
  

  Map<String, List<String>> animalsByZone = {
    'Tropical': ['Mandrill', 'Tucán', 'Puma', 'Tigre'],
    'Sabana': ['León', 'Jirafa', 'Elefante', 'Avestruz'],
    'Desierto': ['Serpiente', 'Liebre', 'Coyote', 'Camello'],
  };

  List<String> selectedAnimals = [];

  List<String> availableStops = ['Restaurante', 'Evento 1', 'Evento 2'];
  
  List<String> selectedStops = [];

  List<String> selectedPoints = [];

List<String> combineAnimalLists(List<String> selectedZones) {
  List<String> combinedList = [];

  for (String zone in selectedZones) {
    combinedList.addAll(animalsByZone[zone] ?? []);
  }

  return combinedList;
}

  bool loading = false;

  @override
  void initState() {
    super.initState();
    selectedAnimals = List.from(widget.initialSelectedAnimals);
  }

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
          'Personaliza tu ruta',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildZoneSelection(),
           buildCheckList(
              '¿Qué animales quieres ver?',
              combineAnimalLists(selectedZone.split(', ')),
              selectedAnimals,
            ),
            buildCheckList(
              '¿Quieres hacer una parada adicional a tu recorrido?',
              availableStops,
              selectedStops,
            ),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                ),
                onPressed: () async {
                  setState(() {
                    loading = true;
                    selectedPoints = [...selectedAnimals, ...selectedStops];
                  });
                  await Future.delayed(const Duration(seconds: 2));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Polyline1(selectedPoints: selectedPoints),
                    ),
                  );
                },
                child: const Text('Generar recorrido'),
              ),
            ),
            if (loading) const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

Widget buildZoneSelection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          '¿Qué zona deseas visitar?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      DropdownButton<List<String>>(
        onChanged: (selectedZones) {
          setState(() {
            if (selectedZones!.contains('Todas las zonas')) {
              // Si 'Todas las zonas' está seleccionado, muestra todos los animales
              selectedZone = availableZones.join(', '); // Muestra todas las zonas como una cadena separada por comas
            } else {
              selectedZone = selectedZones.join(', '); // Muestra las zonas seleccionadas como una cadena separada por comas
            }
          });
        },
        items: [
          DropdownMenuItem<List<String>>(
            value: availableZones,
            child: const Text('Todas las zonas'),
          ),
          ...availableZones.map((zone) {
            return DropdownMenuItem<List<String>>(
              value: [zone],
              child: Text(zone),
            );
          }).toList(),
          const DropdownMenuItem<List<String>>(
            value: ['Tropical', 'Sabana'],
            child: Text('Tropical + Sabana'),
          ),
          const DropdownMenuItem<List<String>>(
            value: ['Desierto', 'Sabana'],
            child: Text('Desierto + Sabana'),
          ),
          const DropdownMenuItem<List<String>>(
            value: ['Tropical', 'Desierto'],
            child: Text('Tropical + Desierto'),
          ),
        ],
      ),
    ],
  );
}

  Widget buildCheckList(String title, List<String> items, List<String> selectedItems) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return CheckboxListTile(
            title: Text(item),
            value: selectedItems.contains(item),
            onChanged: (value) {
              setState(() {
                if (value!) {
                  selectedItems.add(item);
                } else {
                  selectedItems.remove(item);
                }
              });
            },
          );
        },
      ),
    ],
  );
}
}

