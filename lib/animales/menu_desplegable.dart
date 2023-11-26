import 'package:biomovil/animales/menu_habitats.dart';
import 'package:biomovil/qr/lector_qr.dart';
import 'package:biomovil/pantalla_ajustes/ajustes.dart';
import 'package:biomovil/principal/pagina_principal.dart';
import 'package:biomovil/recorridos/nuevo-recorrido.dart';
import 'package:flutter/material.dart';

class MyDropdownMenu extends StatelessWidget {
  final List<String> items;
  final String selectedItem;
  final ValueChanged<String?> onChanged;

  const MyDropdownMenu({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(context),
          buildMenuItems(context),
        ],
      ),
    ),
  );
  Widget buildHeader(BuildContext context) => Container(
    padding: EdgeInsets.only(
      top: MediaQuery.of(context).padding.top,
    ),
  );
  Widget buildMenuItems(BuildContext context) => Container(
    padding: const EdgeInsets.all(24),
    child: Wrap(
      runSpacing: 16,
      children: [
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Pagina principal'),
          onTap: ()=>
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context)=>const PaginaPrincipal(),
            )),
        ),
        ListTile(
          leading: const Icon(Icons.pets_outlined),
          title: const Text('Animales'),
          onTap: ()=>
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context)=> MenuHabitats(),
            )),
        ),
        const Divider(color: Colors.black54),
        ListTile(
          leading: const Icon(Icons.qr_code_2_outlined),
          title: const Text('Escanear QR'),
          onTap: ()=>
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context)=> LectorCQR(),
            )),
        ),
        ListTile(
          leading: const Icon(Icons.map_outlined),
          title: const Text('Recorridos'),
          onTap: ()=>
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context)=>const SelectionScreen(initialSelectedAnimals: [],),
            )),
        ),
        ListTile(
          leading: const Icon(Icons.settings_applications_outlined),
          title: const Text('Ajustes'),
          onTap: ()=>
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context)=>const Ajustes(),
            )),
        ),
      ],
    ),
  );
}

void main() {
runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/',
  routes: {
    '/': (context) => const MyAppAnimalesTropicales(),
    '/pagina_principal': (context) => const PaginaPrincipal(),
    '/menu_habitats': (context) => MenuHabitats(),
    '/lector_qr': (context) => LectorCQR(),
    '/recorridos': (context) => const SelectionScreen(initialSelectedAnimals: [],),
    '/ajustes': (context) => const Ajustes(),
  },
));
}


class MyAppAnimalesTropicales extends StatefulWidget {
  const MyAppAnimalesTropicales({super.key});

  @override
  _MyAppAnimalesTropicalesState createState() =>
      _MyAppAnimalesTropicalesState();
}

class _MyAppAnimalesTropicalesState extends State<MyAppAnimalesTropicales> {
  final List<TropicalCardData> cardData = [
    TropicalCardData("Tucan", "assets/tucan.jpg"),
    TropicalCardData("Mandrill", "assets/mandrill.jpg"),
    TropicalCardData("Puma", "assets/puma.jpg"),
    TropicalCardData("Tigre", "assets/tigre.jpg"),
  ];

  List<TropicalCardData> filteredCardData = [];

  @override
  void initState() {
    super.initState();
    filteredCardData = List.from(cardData);
  }

  void filterByKeyword(String keyword) {
    setState(() {
      if (keyword.isEmpty) {
        filteredCardData = List.from(cardData);
      } else {
        filteredCardData = cardData
            .where((animal) =>
                animal.habitat.toLowerCase().contains(keyword.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
            "Animales",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          leading: MyDropdownMenu(
            items: const [
              "Pagina principal",
              "Animales",
              "Codigo QR",
              "Recorridos",
              "Ajustes",
            ],
            selectedItem: "Pagina principal",
            onChanged: (String? item) {
              print("Item seleccionado: $item");

              switch (item) {
                case "Pagina principal":
                  Navigator.of(context).pushReplacementNamed('/');
                  break;
                case "Animales":
                  Navigator.of(context).pushReplacementNamed('/menu_habitats');
                  break;
                case "Codigo QR":
                  Navigator.of(context).pushReplacementNamed('/lector_qr');
                  break;
                case "Recorridos":
                  Navigator.of(context).pushReplacementNamed('/recorridos');
                  break;
                case "Ajustes":
                  Navigator.of(context).pushReplacementNamed('/ajustes');
                  break;
              }
            },
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: filterByKeyword,
                decoration: InputDecoration(
                  hintText: 'Buscar por nombre',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: filteredCardData.length,
                itemBuilder: (BuildContext context, int index) {
                  return AnimalCard(data: filteredCardData[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TropicalCardData {
  final String habitat;
  final String imagePath;

  TropicalCardData(this.habitat, this.imagePath);
}

class AnimalCard extends StatelessWidget {
  final TropicalCardData data;

  const AnimalCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(data.imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Text(
              data.habitat,
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
