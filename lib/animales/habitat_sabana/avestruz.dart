import 'package:biomovil/app_styles.dart';
import 'package:biomovil/size_config.dart';
import 'package:biomovil/animales/ubicacion_animales.dart';
import 'package:biomovil/widgets/menu_principal.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:audioplayers/audioplayers.dart';

AudioPlayer audioPlayer = AudioPlayer();

class Avestruz extends StatelessWidget {
  Avestruz({super.key});

  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kLightWhite,
      body:Column(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, //separa los iconos
                      children: [
                        //boton para volver atras
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const MenuPrincipal()),
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
                        'Avestruz',
                        style: kPoppinsBold.copyWith(
                          color:kDarkBlue,
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
                      horizontal: SizeConfig.blockSizeHorizontal!*2.5,
                    ),
                    height: 40,
                    width: double.infinity,
                    //boton para escuchar el sonido del animal
                    child: ElevatedButton(
                      child: const Text('¡Escucha su sonido!'),
                        onPressed: (){
                        playAudio();
                      },
                    ),
                  ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kPaddingHorizontal,
                            vertical: 12,
                          ),
                          child: Text(
                            'Nombre cientifico: Struthio camelus\nFamilia: Struthionidae\nClase: Aves\nPromedio de vida: 30 a 40 años\nAltura:  2.5 a 3 metros\nPeso: 140 a 160 kg\nColores: Tienen plumaje de color marrón \n a gris, con algunas plumas negras en \n las alas y la cola. La cabeza y el cuello carecen de plumas y son de color rosa \n o gris claro.',
                            style: kPoppinsRegular.copyWith(
                              fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                              color: kDarkBlue,
                            ),
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const UbicacionAnimal(),
                              ));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber[800], // Cambia el color de fondo aquí
                            ),
                            child: const Text('Ver Ubicación'),
                          ),
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
    await player.play(AssetSource('avestruz.mp3'));
  }
}

final List<String> imageList = [
  'assets/animales/sabana/avestruz1.jpg',
  'assets/animales/sabana/avestruz2.jpg',
  'assets/animales/sabana/avestruz3.jpg'
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
              bottom: 20
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
