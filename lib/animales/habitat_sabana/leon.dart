import 'package:biomovil/animales/habitat_sabana/animales_sabana.dart';
import 'package:biomovil/animales/habitat_sabana/ubicaciones/ubicacion_leon.dart';
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
import 'apis_sabana/api_leon.dart';

AudioPlayer audioPlayer = AudioPlayer();

class Leon extends StatefulWidget {
  @override
  _LeonState createState() => _LeonState();
}

final player = AudioPlayer();
final List<String> menuItems = [
  "Pagina principal",
  "Animales",
  "Codigo QR",
  "Ubicacion",
  "Ajustes",
];

class _LeonState extends State<Leon> {
  final APILeon _animalAPI = APILeon();
  Map<String, dynamic> LeonInfo =
      {};

  @override
  void initState() {
    super.initState();
    fetchLeonInfo();
  }

  void fetchLeonInfo() async {
    var info = await _animalAPI.fetchLeonData();
    setState(() {
      LeonInfo = info;
    });
  }

  void main() {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Leon(),
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
                const FullScreenSlider(),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 40,
                    ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AnimalesSabana()),
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
                        Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Text(
                              'León',
                              style: kPoppinsBold.copyWith(
                                color: kDarkBlue,
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
                          child: LeonInfo
                                  .isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInfoRow(
                                        'Nombre científico',
                                        LeonInfo['taxonomy']
                                                ['scientific_name'] ??
                                            'N/A'),
                                    _buildInfoRow(
                                        'Reino',
                                        LeonInfo['taxonomy']['kingdom'] ??
                                            'N/A'),
                                    _buildInfoRow('Clase',
                                        LeonInfo['taxonomy']['class'] ?? 'N/A'),
                                    _buildInfoRow('Orden',
                                        LeonInfo['taxonomy']['order'] ?? 'N/A'),
                                    _buildInfoRow(
                                        'Familia',
                                        LeonInfo['taxonomy']['family'] ??
                                            'N/A'),
                                    _buildInfoRow('Género',
                                        LeonInfo['taxonomy']['genus'] ?? 'N/A'),
                                    _buildInfoRow(
                                        'Promedio de vida',
                                        LeonInfo['characteristics']
                                                ['lifespan'] ??
                                            'N/A'),
                                    _buildInfoRow(
                                        'Altura',
                                        LeonInfo['characteristics']['height'] ??
                                            'N/A'),
                                    _buildInfoRow(
                                        'Peso',
                                        LeonInfo['characteristics']['weight'] ??
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
                                                const UbicacionLeon(),
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
                              : CircularProgressIndicator(),
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
    await player.play(AssetSource('leon.mp3'));
  }
}

final List<String> imageList = [
  'assets/animales/sabana/leon1.jpg',
  'assets/animales/sabana/leon2.jpg',
  'assets/animales/sabana/leon4.jpg'
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
