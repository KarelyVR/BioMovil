import 'package:flutter/material.dart';
import 'package:biomovil/articulos/e_renovable.dart';
import 'package:biomovil/articulos/marpol.dart';
import 'package:biomovil/articulos/panda.dart';
import 'package:biomovil/articulos/pangolin.dart';
import 'package:biomovil/articulos/pez_matusalen.dart';
import 'package:biomovil/articulos/tarantula.dart';
import 'package:biomovil/principal/pagina_principal.dart';
import 'package:biomovil/animales/menu_desplegable.dart' as menu;

class MenuArticulos extends StatelessWidget {
  final List<ArticulosCardData> cardData = [
    ArticulosCardData("Conservación del Pangolin", "assets/articulos/pangolin.jpg"),
    ArticulosCardData("Conoce al pez más viejo en un acuario", "assets/articulos/pez.jpg"),
    ArticulosCardData("Descubren en Tailandia una especie de tarántula azul eléctrica", "assets/articulos/tarantula.jpg"),
    ArticulosCardData("Oso Panda Gigante: la lenta recuperación de un ícono", "assets/articulos/panda.jpg"),
    ArticulosCardData("Contaminación del mar y las costas", "assets/articulos/contaminacion.jpg"),
    ArticulosCardData("La importancia de las energías renovables", "assets/articulos/renovables1.jpg"),
  ];

  final List<String> menuItems = [
    "Pagina principal",
    "Animales",
    "Codigo QR",
    "Recorridos",
    "Ajustes",
  ];

  final String selectedMenuItem;

  MenuArticulos({Key? key}) : selectedMenuItem = "Ultimas noticias", super(key: key);

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
            'Ultimas noticias',
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
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 40.0),
                  ...cardData.map((data) {
                    return GestureDetector(
                      onTap: () {
                        navigateToArticle(context, data.habitat);
                      },
                      child: AnimalCard(
                        data: data,
                        sampleText: getSampleText(data.habitat),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void navigateToArticle(BuildContext context, String habitat) {
    switch (habitat) {
      case "Conservación del Pangolin":
        Navigator.push(context, MaterialPageRoute(builder: (context) => Pangolin()));
        break;
      case "Conoce al pez más viejo en un acuario":
        Navigator.push(context, MaterialPageRoute(builder: (context) => PezMatusalem()));
        break;
      case "Descubren en Tailandia una especie de tarántula azul eléctrica":
        Navigator.push(context, MaterialPageRoute(builder: (context) => Tarantula()));
        break;
      case "Oso Panda Gigante: la lenta recuperación de un ícono":
        Navigator.push(context, MaterialPageRoute(builder: (context) => Panda()));
        break;
      case "Contaminación del mar y las costas":
        Navigator.push(context, MaterialPageRoute(builder: (context) => Contaminacion()));
        break;
      case "La importancia de las energías renovables":
        Navigator.push(context, MaterialPageRoute(builder: (context) => Renovables()));
        break;
    }
  }

  String getSampleText(String habitat) {
    switch (habitat) {
      case "Conservación del Pangolin":
        return "Estas escurridizas criaturas están bajo amenaza, pero el descubrimiento de una especie misteriosa podría ayudar a los conservacionistas.";
      case "Conoce al pez más viejo en un acuario":
        return "Un pez pulmonado de entre 83 y 101 años es la sensación del acuario Steinhart en San Francisco.";
      case "Descubren en Tailandia una especie de tarántula azul eléctrica":
        return 'El azul es sorprendentemente raro en la naturaleza, por eso los expertos dicen que esta araña iridiscente "es algo destinado a ser visto".';
      case "Oso Panda Gigante: la lenta recuperación de un ícono":
        return "En 2021, los pandas se convirtieron según propagó el Gobierno chino en un éxito de conservación.";
      case "Contaminación del mar y las costas":
        return "Se estima que el 80% de los contaminantes presentes en el medio marino proceden de la tierra.";
      case "La importancia de las energías renovables":
        return "El desarrollo de las energías límpias es imprescindible para combatir el cambio climatico y limitar sus efectos más devastadores.";
      default:
        return "Texto de ejemplo no disponible.";
    }
  }
}

class ArticulosCardData {
  final String habitat;
  final String imagePath;

  ArticulosCardData(this.habitat, this.imagePath);
}

class AnimalCard extends StatelessWidget {
  final ArticulosCardData data;
  final String sampleText;

  const AnimalCard({Key? key, required this.data, required this.sampleText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(data.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                data.habitat,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                sampleText,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
