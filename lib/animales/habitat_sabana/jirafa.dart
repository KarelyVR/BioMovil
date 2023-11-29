// ignore_for_file: avoid_print, library_private_types_in_public_api, non_constant_identifier_names

import 'package:biomovil/animales/habitat_sabana/apis_sabana/api_jirafa.dart';
import 'package:biomovil/animales/habitat_sabana/ubicaciones/ubicacion_jirafa.dart';
import 'package:biomovil/animales/habitat_sabana/animales_sabana.dart';
import 'package:biomovil/themes/app_styles.dart';
import 'package:biomovil/themes/size_config.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:biomovil/animales/menu_desplegable.dart' as menu;

AudioPlayer audioPlayer = AudioPlayer();

class Jirafa extends StatefulWidget {
  const Jirafa({Key? key}) : super(key: key);

  @override
  _JirafaState createState() => _JirafaState();
}

final player = AudioPlayer();
final List<String> imageList = [
  'assets/animales/sabana/jirafa1.jpeg',
  'assets/animales/sabana/jirafa2.jpg',
  'assets/animales/sabana/jirafa3.jpg'
];

class _JirafaState extends State<Jirafa> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final APIJirafa _animalAPI = APIJirafa();
  late Map<String, dynamic> JirafaInfo;

  @override
  void initState() {
    super.initState();
    JirafaInfo = {};
    fetchDataInIsolate();
  }

  void fetchDataInIsolate() async {
    // Supongamos que aquí tienes la lógica para cargar los datos
    // de manera asíncrona, por ejemplo, desde una API.
    try {
      var loadedData = await _animalAPI.fetchJirafaData();
      setState(() {
        JirafaInfo = loadedData;
      });
    } catch (e) {
      print("Error cargando datos: $e");
      // Manejar el error según tus necesidades
    }
  }

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
                                  const AnimalesSabana()),
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
                ),
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
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Text(
                            'Jirafa',
                            style: kPoppinsBold.copyWith(
                              color: Colors.blue, // Cambiado a color de ejemplo
                              fontSize: SizeConfig.blockSizeHorizontal! * 7,
                            ),
                          ),
                        ),
                      ),
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
                        child: JirafaInfo.isNotEmpty
                            ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow(
                                'Nombre científico',
                                JirafaInfo['taxonomy']
                                ['scientific_name'] ??
                                    'N/A'),
                            _buildInfoRow(
                                'Reino',
                                JirafaInfo['taxonomy']['kingdom'] ??
                                    'N/A'),
                            _buildInfoRow(
                                'Clase',
                                JirafaInfo['taxonomy']['class'] ??
                                    'N/A'),
                            _buildInfoRow(
                                'Orden',
                                JirafaInfo['taxonomy']['order'] ??
                                    'N/A'),
                            _buildInfoRow(
                                'Familia',
                                JirafaInfo['taxonomy']['family'] ??
                                    'N/A'),
                            _buildInfoRow(
                                'Género',
                                JirafaInfo['taxonomy']['genus'] ??
                                    'N/A'),
                            _buildInfoRow(
                                'Promedio de vida',
                                JirafaInfo['characteristics']
                                ['lifespan'] ??
                                    'N/A'),
                            _buildInfoRow(
                                'Altura',
                                JirafaInfo['characteristics']
                                ['height'] ??
                                    'N/A'),
                            _buildInfoRow(
                                'Peso',
                                JirafaInfo['characteristics']
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
                                    const UbicacionJirafa(),
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
                            : const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void playAudio() async {
    await player.play(AssetSource('jirafa.mp3'));
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
}

class FullScreenSlider extends StatefulWidget {
  const FullScreenSlider({Key? key}) : super(key: key);

  @override
  _FullScreenSliderState createState() => _FullScreenSliderState();
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
