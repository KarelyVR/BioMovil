// ignore_for_file: avoid_print, library_private_types_in_public_api, non_constant_identifier_names

import 'package:biomovil/animales/habitat_tropical/animales_tropicales.dart';
import 'package:biomovil/animales/habitat_tropical/ubicaciones/ubicacion_tigre.dart';
import 'package:biomovil/animales/menu_habitats.dart';
import 'package:biomovil/themes/app_styles.dart';
import 'package:biomovil/qr/lector_qr.dart';
import 'package:biomovil/pantalla_ajustes/ajustes.dart';
import 'package:biomovil/principal/pagina_principal.dart';
import 'package:biomovil/recorridos/nuevo_recorrido.dart';
import 'package:biomovil/themes/size_config.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:biomovil/animales/menu_desplegable.dart' as menu;
import 'apis_tropical/api_tigre.dart';

AudioPlayer audioPlayer = AudioPlayer();

class Tigre extends StatefulWidget {
  const Tigre({super.key});

  @override
  _TigreState createState() => _TigreState();
}

final player = AudioPlayer();
final List<String> menuItems = [
  "Pagina principal",
  "Animales",
  "Codigo QR",
  "Ubicacion",
  "Ajustes",
];

class _TigreState extends State<Tigre> {
  final APITigre _animalAPI = APITigre(); // Instancia de la clase AnimalAPI
  Map<String, dynamic> TigreInfo =
  {}; // Almacenará los datos del tucán desde la API

  @override
  void initState() {
    super.initState();
    fetchTigreInfo(); // Llama a la función para obtener los datos del tucán al inicio
  }

  void fetchTigreInfo() async {
    var info = await _animalAPI.fetchTigreData(); // Llama al método de la API
    setState(() {
      TigreInfo = info; // Actualiza los datos del tucán en el estado
    });
  }

  void main() {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Tigre(),
        '/pagina_principal': (context) => const PaginaPrincipal(),
        '/menu_habitats': (context) => MenuHabitats(),
        '/lector_qr': (context) => LectorCQR(),
        '/recorridos': (context) => const SelectionScreen(initialSelectedAnimals: [],),
        '/ajustes': (context) => const Ajustes(),
      },
    ));
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: scaffoldKey,
      drawer: const menu.NavigationDrawer(),
      backgroundColor: kLightWhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 40,
            child: Stack(
              children: [
                const FullScreenSlider(), //carrusel
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 40,
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, //separa los iconos
                      children: [
                        //boton para volver atras
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const AnimalesTropicales()),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: kWhite,
                              boxShadow: const [
                                BoxShadow(
                                  color: kDarkBlue,
                                  blurRadius: 6,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 28,
                            ),
                          ),
                        ),
                        //boton de pagina principal
                        InkWell(
                          onTap: () {
                            scaffoldKey.currentState?.openDrawer();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: kWhite,
                              boxShadow: const [
                                BoxShadow(
                                  color: kDarkBlue,
                                  blurRadius: 6,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(
                              Icons.sort_rounded,
                              size: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //texto grande del nombre del animal
                        Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Text(
                              'Tigre',
                              style: kPoppinsBold.copyWith(
                                color: kDarkBlue,
                                fontSize: SizeConfig.blockSizeHorizontal! * 7,
                              ),
                            ),
                          ),
                        ),
                        //este es el boton de audio
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: kPaddingHorizontal,
                            vertical: 10,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.blockSizeHorizontal! * 2.5,
                          ),
                          height: 40,
                          width: double.infinity,
                          //boton para escuchar el sonido del animal
                          child: ElevatedButton(
                            child: const Text('¡Escucha su sonido!'),
                            onPressed: () {
                              playAudio();
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kPaddingHorizontal,
                            vertical: 12,
                          ),
                          child: TigreInfo
                              .isNotEmpty // Verifica si los datos están presentes
                              ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInfoRow(
                                  'Nombre científico',
                                  TigreInfo['taxonomy']
                                  ['scientific_name'] ??
                                      'N/A'),
                              _buildInfoRow(
                                  'Reino',
                                  TigreInfo['taxonomy']['kingdom'] ??
                                      'N/A'),
                              _buildInfoRow(
                                  'Clase',
                                  TigreInfo['taxonomy']['class'] ??
                                      'N/A'),
                              _buildInfoRow(
                                  'Orden',
                                  TigreInfo['taxonomy']['order'] ??
                                      'N/A'),
                              _buildInfoRow(
                                  'Familia',
                                  TigreInfo['taxonomy']['family'] ??
                                      'N/A'),
                              _buildInfoRow(
                                  'Género',
                                  TigreInfo['taxonomy']['genus'] ??
                                      'N/A'),
                              _buildInfoRow(
                                  'Promedio de vida',
                                  TigreInfo['characteristics']
                                  ['lifespan'] ??
                                      'N/A'),
                              _buildInfoRow(
                                  'Longitud',
                                  TigreInfo['characteristics']
                                  ['length'] ??
                                      'N/A'),
                              _buildInfoRow(
                                  'Peso',
                                  TigreInfo['characteristics']
                                  ['weight'] ??
                                      'N/A'),
                              const SizedBox(
                                height: 30,
                              ),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                      const UbicacionTigre(),
                                    ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.amber[800],
                                  ),
                                  child: const Text('Ver Ubicación'),
                                ),
                              ),
                            ],
                          )
                              : const CircularProgressIndicator(), // Muestra un indicador de carga si los datos aún no han sido obtenidos
                        ),
                      ]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void playAudio() async {
    await player.play(AssetSource('tigre.mp3'));
  }
}

final List<String> imageList = [
  'assets/animales/tropical/tigre1.jpg',
  'assets/animales/tropical/tigre2.jpg',
  'assets/animales/tropical/tigre4.jpg'
];

class FullScreenSlider extends StatefulWidget {
  const FullScreenSlider({super.key});

  @override
  State<FullScreenSlider> createState() => _FullScreenSliderState();
}

class _FullScreenSliderState extends State<FullScreenSlider> {
  int _current = 1;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            height: SizeConfig.blockSizeVertical! * 50,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
            initialPage: _current,
            autoPlay: true, // Activar la reproducción automática
            autoPlayInterval:
            const Duration(seconds: 3), // Intervalo entre cambios de imagen
          ),
          items: imageList
              .map((item) => Center(
            child: Image.asset(
              item,
              fit: BoxFit.cover,
              height: SizeConfig.blockSizeVertical! * 50,
              width: double.infinity,
            ),
          ))
              .toList(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imageList
                  .asMap()
                  .entries
                  .map((entry) => GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: SvgPicture.asset(
                    _current == entry.key
                        ? 'assets/carousel_indicator_enabled.svg'
                        : 'assets/carousel_indicator_disabled.svg',
                  ),
                ),
              ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildInfoRow(String title, String content) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
        children: [
          TextSpan(
            text: '$title: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: content,
          ),
        ],
      ),
    ),
  );
}
