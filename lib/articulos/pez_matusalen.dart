// ignore_for_file: avoid_print

import 'menu_articulos.dart';
import 'package:biomovil/themes/app_styles.dart';
import 'package:biomovil/themes/size_config.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:biomovil/animales/menu_desplegable.dart' as menu;


class PezMatusalem extends StatelessWidget {
  PezMatusalem({super.key});

  final List<String> menuItems = [
    "Pagina principal",
    "Animales",
    "Codigo QR",
    "Ubicacion",
    "Ajustes",
  ];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: scaffoldKey,
      drawer: const menu.NavigationDrawer(),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>   MenuArticulos()),
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
                            'Conoce al pez más viejo en un acuario',
                            style: kPoppinsBold.copyWith(
                              color:kDarkBlue,
                              fontSize: SizeConfig.blockSizeHorizontal! * 7,
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kPaddingHorizontal,
                          vertical: 12,
                        ),
                        child: Text(
                          'Un pez pulmonado de entre 83 y 101 años es la sensación del acuario de Steinhart, en San Francisco (California), a donde llegó en 1938, a bordo de un barco desde Australia y desde entonces ahí ha permanecido convirtiéndose en el pez más viejo que ha vivido en cautiverio.\nPero las curiosidades de esta criatura van más allá, comenzando por su singular nombre, Matusalén en referencia al longevo personaje bíblico, y no solo eso, sino que se trata de un fósil viviente y s ele ha catalogado así debido a que se han hallado fósiles de hace 380 millones de años, con sus mismas características.\nCalcular la edad exacta de un ser vivo, sin hacerle daño o matarlo, es muy complicado por lo que, en el caso de Matusalén, se sabe que lleva 83 años en el acuario, su edad oficial, aunque es probable que ya rondé los 100.\nPara conoce la edad exacta de un pez es necesario examinar los huesos de las orejas, y la extracción de escamas enteras, sin embargo, esto resultaría muy doloroso para el longevo animal.\nEn tanto, la Academia de Ciencias de California desarrolló un nuevo método que utiliza una diminuta muestra de tejido de un recorte de aleta de menos de 0.5 centímetros cuadrados y que no produce ningún daño al animal.',
                          textAlign: TextAlign.justify,
                          style: kPoppinsRegular.copyWith(
                            fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                            color: kDarkBlue,
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


}

final List<String> imageList = [
  'assets/articulos/pez1.jpg',
  'assets/articulos/pez2.jpg',
  'assets/articulos/pez3.jpg',
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
              )
          ),
        ),
      ],
    );
  }
}