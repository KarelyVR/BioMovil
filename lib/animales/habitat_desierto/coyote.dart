// ignore_for_file: avoid_print

import 'package:biomovil/animales/habitat_desierto/animales_desierto.dart';
import 'package:biomovil/animales/habitat_desierto/ubicaciones/ubicacion_coyote.dart';
import 'package:biomovil/animales/menu_habitats.dart';
import 'package:biomovil/recorridos/nuevo_recorrido.dart';
import 'package:biomovil/themes/app_styles.dart';
import 'package:biomovil/qr/lector_qr.dart';
import 'package:biomovil/pantalla_ajustes/ajustes.dart';
import 'package:biomovil/principal/pagina_principal.dart';
import 'package:biomovil/themes/size_config.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:biomovil/animales/menu_desplegable.dart' as menu;
import 'apis_desierto/api_coyote.dart';

AudioPlayer audioPlayer = AudioPlayer();

class Coyote extends StatefulWidget {
  @override
  _CoyoteState createState() => _CoyoteState();
}

final player = AudioPlayer();
final List<String> menuItems = [
  "Pagina principal",
  "Animales",
  "Codigo QR",
  "Ubicacion",
  "Ajustes",
];

class _CoyoteState extends State<Coyote> {
  final APICoyote _animalAPI = APICoyote(); // Instancia de la clase AnimalAPI
  Map<String, dynamic> CoyoteInfo =
      {}; // Almacenará los datos del tucán desde la API

  @override
  void initState() {
    super.initState();
    fetchCoyoteInfo(); // Llama a la función para obtener los datos del tucán al inicio
  }

  void fetchCoyoteInfo() async {
    var info = await _animalAPI.fetchCoyoteData(); // Llama al método de la API
    setState(() {
      CoyoteInfo = info; // Actualiza los datos del coyote en el estado
    });
  }

  void main() {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Coyote(),
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
                        InkWell(
                          //boton para volver atras
                        onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AnimalesDesierto()),
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
                              'Coyote',
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
                          child: ElevatedButton(
                            //boton para escuchar el sonido del animal
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
                          child: CoyoteInfo
                                  .isNotEmpty // Verifica si los datos están presentes
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInfoRow(
                                        'Nombre científico',
                                        CoyoteInfo['taxonomy']
                                                ['scientific_name'] ??
                                            'N/A'),
                                    _buildInfoRow(
                                        'Reino',
                                        CoyoteInfo['taxonomy']['kingdom'] ??
                                            'N/A'),
                                    _buildInfoRow(
                                        'Clase',
                                        CoyoteInfo['taxonomy']['class'] ??
                                            'N/A'),
                                    _buildInfoRow(
                                        'Orden',
                                        CoyoteInfo['taxonomy']['order'] ??
                                            'N/A'),
                                    _buildInfoRow(
                                        'Familia',
                                        CoyoteInfo['taxonomy']['family'] ??
                                            'N/A'),
                                    _buildInfoRow(
                                        'Género',
                                        CoyoteInfo['taxonomy']['genus'] ??
                                            'N/A'),
                                    _buildInfoRow(
                                        'Promedio de vida',
                                        CoyoteInfo['characteristics']
                                                ['lifespan'] ??
                                            'N/A'),
                                    _buildInfoRow(
                                        'Longitud',
                                        CoyoteInfo['characteristics']
                                                ['length'] ??
                                            'N/A'),
                                    _buildInfoRow(
                                        'Peso',
                                        CoyoteInfo['characteristics']
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
                                                const UbicacionCoyote(),
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
                              : CircularProgressIndicator(), // Muestra un indicador de carga si los datos aún no han sido obtenidos
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
    await player.play(AssetSource('coyote.mp3'));
  }
}

final List<String> imageList = [
  'assets/animales/desierto/coyote1.jpg',
  'assets/animales/desierto/coyote2.jpg',
  'assets/animales/desierto/coyote4.jpg'
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
            autoPlay: true,
            autoPlayInterval:
                const Duration(seconds: 3),
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
            padding: const EdgeInsets.only(bottom: 20),
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
