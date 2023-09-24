import 'package:biomovil/app_styles.dart';
import 'package:biomovil/size_config.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:audioplayers/audioplayers.dart';

AudioPlayer audioPlayer = AudioPlayer();

class AnimalesDetalles extends StatelessWidget {
 AnimalesDetalles({super.key});

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
            height: SizeConfig.blockSizeVertical! * 50,
            child: Stack(
              children: [
                const FullScreenSlider(), //carrusel
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 35,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(42),
                        topRight: Radius.circular(42),
                      ),
                      color: kLighterWhite,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kPaddingHorizontal,
                      vertical: 40,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, //separa los iconos
                      children: [
                        //boton para volver atras
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              kBorderRadius,
                            ),
                            border: Border.all(
                              color: kWhite,
                            ),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset('assets/arrow_back_icon.svg'
                          ),
                        ),
                        //boton de pagina principal
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              kBorderRadius,
                            ),
                            border: Border.all(
                              color: kWhite,
                            ),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset('assets/home_selected_icon.svg'
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
<<<<<<< Updated upstream
            ElevatedButton(
            onPressed: () {
//              playAudio(); // Llama al método playAudio cuando se presiona el botón
            },
            child: const Text("Reproducir Audio"),
            ),
            Container(
=======
          ),
          Expanded(
          child: ListView.builder(
          itemCount: 1, // Puedes ajustar esto según tu contenido
          itemBuilder: (context, index) {
            return Padding(
>>>>>>> Stashed changes
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
                      transform: Matrix4.translationValues(0, -30, 0),
                      child: Text(
                        'Tucán',
                        style: kPoppinsBold.copyWith(
                          color:kDarkBlue,
                          fontSize: SizeConfig.blockSizeHorizontal! * 7,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    transform: Matrix4.translationValues(0, -20, 0),
                    margin: const EdgeInsets.symmetric(
                      horizontal: kPaddingHorizontal,
                      vertical: 11,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal!*2.5,
                    ),
                    height: 54,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        kBorderRadius,
                      ),
                      border: Border.all(
                        color: kBorderColor,
                      ),
                    ),
                    //boton para escuchar el sonido del animal
                    child: ElevatedButton(
                      child: const Text('¡Escucha su sonido!'),
                        onPressed: (){
                        playAudio();
                      },
                    ),
                  ),
                  Padding(
                    padding:const EdgeInsets.symmetric(
                      horizontal: kPaddingHorizontal,
                    ),
                    child: Text(
                    'Nombre cientifico: Ramphastos toco\nFamilia: Ramphastidae\nClase: Aves\nPromedio de vida: 15 a 20 años\nAltura: 48 a 61 cm\nPeso: 130 a 680 g\nColores: Tienen plumaje negro con colores brillantes en sus picos y algunas areas del rostro. Incluyen tonos de amarillo, naranja, rojo y verde en sus picos y areas cercanas.',
                    textAlign: TextAlign.justify,  
                      style: kPoppinsRegular.copyWith(
                        fontSize: SizeConfig.blockSizeHorizontal! * 4,
                        color: kDarkBlue,
                      ),
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
  await player.play(AssetSource('tucan.mp3'));
}
}

<<<<<<< Updated upstream
//void playAudio() async {
//  int result = await audioPlayer.play(" URL_DEL_ARCHIVO_DE_AUDIO.mp3");
//  if (result == 1) {
//    // La reproducción del audio se inició con éxito
//    print('Reproduciendo audio');
//  }
//}
=======

>>>>>>> Stashed changes

final List<String> imageList = [
  'assets/toucan1.jpg',
  'assets/toucan2.jpg',
  'assets/toucan3.jpg'
  ];

class FullScreenSlider extends StatefulWidget {
  const FullScreenSlider({super.key});

  @override
  State<FullScreenSlider> createState() =>  _FullScreenSliderState();
}

class  _FullScreenSliderState extends State<FullScreenSlider> {

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
            autoPlayInterval: const Duration(seconds: 3), // Intervalo entre cambios de imagen
          ),
          items: imageList.map((item) => Center(
            child: Image.asset(
              item,
              fit: BoxFit.cover,
              height: SizeConfig.blockSizeVertical! * 50,
              width: double.infinity,
            ),
          )).toList(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 52
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6),
                        child: SvgPicture.asset(_current == entry.key 
                        ? 'assets/carousel_indicator_enabled.svg'
                        : 'assets/carousel_indicator_disabled.svg',
                        ),
                      ),
                  )
                )
                .toList(),
              ),
            ),
        ),
      ],
    );
  }
}