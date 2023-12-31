// Importa los paquetes y archivos necesarios
// ignore_for_file: sized_box_for_whitespace, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:biomovil/animales/habitat_tropical/animales_tropicales.dart';
import 'package:biomovil/animales/habitat_tropical/ubicaciones/ubicacion_tucan.dart';
import 'package:biomovil/themes/app_styles.dart';
import 'package:biomovil/themes/size_config.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:audioplayers/audioplayers.dart';
import 'apis_tropical/api_tucan.dart';

// Define el reproductor de audio como una variable global
AudioPlayer audioPlayer = AudioPlayer();

class Tucan extends StatefulWidget {
  const Tucan({Key? key}) : super(key: key);

  @override
  _TucanState createState() => _TucanState();
}

final player = AudioPlayer();

class _TucanState extends State<Tucan> {
  final APITucan _animalAPI = APITucan();
  Map<String, dynamic> tucanInfo = {};

  @override
  void initState() {
    super.initState();
    fetchTucanInfo();
  }

  void fetchTucanInfo() async {
    var info = await _animalAPI.fetchTucanData();
    setState(() {
      tucanInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kLightWhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 40,
            child: Stack(
              children: [
                const FullScreenSlider(),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 40,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                                  color: Colors.blue, // Cambiado a color de ejemplo
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
                        InkWell(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: kWhite,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.blue, // Cambiado a color de ejemplo
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
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Text(
                            'Tucán',
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
                        child: tucanInfo.isNotEmpty
                            ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow(
                              'Nombre científico',
                              'Toucan',
                            ),
                            _buildInfoRow(
                              'Reino',
                              tucanInfo['taxonomy']['kingdom'] ?? 'N/A',
                            ),
                            _buildInfoRow(
                              'Clase',
                              tucanInfo['taxonomy']['class'] ?? 'N/A',
                            ),
                            _buildInfoRow(
                              'Orden',
                              tucanInfo['taxonomy']['order'] ?? 'N/A',
                            ),
                            _buildInfoRow(
                              'Familia',
                              tucanInfo['taxonomy']['family'] ?? 'N/A',
                            ),
                            _buildInfoRow(
                              'Género',
                              tucanInfo['taxonomy']['genus'] ?? 'N/A',
                            ),
                            _buildInfoRow(
                              'Promedio de vida',
                              tucanInfo['characteristics']['lifespan'] ??
                                  'N/A',
                            ),
                            _buildInfoRow(
                              'Altura',
                              tucanInfo['characteristics']['height'] ??
                                  'N/A',
                            ),
                            _buildInfoRow(
                              'Peso',
                              tucanInfo['characteristics']['weight'] ??
                                  'N/A',
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                      const UbicacionTucan(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amber[800],
                                ),
                                child: const Text('Ver Ubicación'),
                              ),
                            ),
                          ],
                        )
                            : Center(
                          child: Container(
                            width: 40,
                            height: 40,
                            child: const CircularProgressIndicator(),
                          ),
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
    await player.play(AssetSource('tucan.mp3'));
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

final List<String> imageList = [
  'assets/animales/tropical/toucan1.jpg',
  'assets/animales/tropical/toucan2.jpg',
  'assets/animales/tropical/toucan3.jpg',
];

class FullScreenSlider extends StatefulWidget {
  const FullScreenSlider({Key? key}) : super(key: key);

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
            autoPlayInterval: const Duration(seconds: 3),
          ),
          items: imageList
              .map(
                (item) => Center(
              child: Image.asset(
                item,
                fit: BoxFit.cover,
                height: SizeConfig.blockSizeVertical! * 50,
                width: double.infinity,
              ),
            ),
          )
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
                  .map(
                    (entry) => GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: SvgPicture.asset(
                      _current == entry.key
                          ? 'assets/carousel_indicator_enabled.svg'
                          : 'assets/carousel_indicator_disabled.svg',
                    ),
                  ),
                ),
              )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
