import 'menu_articulos.dart';
import 'package:biomovil/themes/app_styles.dart';
import 'package:biomovil/themes/size_config.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:biomovil/animales/menu_desplegable.dart' as menu;


class Panda extends StatelessWidget {
  Panda({super.key});

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
                        'Oso Panda Gigante: la lenta recuperación de un icono',
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
                            'El oso panda gigante (Ailuropoda melanoleuca) es un insaciable devorador de bambú. Un ejemplar medio se pasa la mitad del día comiendo (literalmente, 12 de cada 24 horas) y hace sus necesidades docenas de veces al día. Hacen falta 12,5 kilogramos de bambú para cubrir las necesidades alimenticias diarias de un panda gigante, que arranca ansiosamente los tallos con los alargados huesos de sus muñecas, usándolos a modo de pulgares. Ocasionalmente también comen pájaros o roedores.\nLos osos panda sólo se encuentran en estado salvaje en remotas regiones montañosas del centro de China. Allí las elevadas plantaciones de bambú son frescas y húmedas, como a ellos les gusta. En verano pueden ascender hasta los 4000 metros de altitud para buscar su alimento en las laderas más altas.\nEn el año 2016, la Unión Internacional de la Conservación de la Naturaleza (UICN) cambió a la especie de amenazada a vulnerable, debido a su crecimiento estable y a los esfuerzos por ampliar su hábitat, pero algunos expertos pedían más cautela para no hundir los esfuerzos de conservación de forma prematura. Según los datos publicados en la Red List de la UICN, hay en 500 y 1000 ejemplares en edad madura y su población está creciendo.\nSin embargo, este oso lleva años sufriendo la caza furtiva por ser un icono de la cultura China, gravemente amenazado por su piel y por el contrabando cuando aún son oseznos. El trabajo para su protección ha resultado ser un ejemplo para la conservación mundial: después de que los años 80 rozasen los 1000 ejemplares salvajes y estuvieran muy cerca de la extinción, sus cifras casi se han duplicado en los últimos 30 años, sacando este emblema del peligro de la extinción.\n\nEn los últimos años, China ha hecho un nuevo Parque Nacional del Panda Gigante, que abarca el 70 por ciento de su hábitat, situado en su mayor parte en la provincia de Sichuan. Desde entonces, el número de pandas en programas de cría en cautividad se ha doblado, alcanzando los 633 pandas, cifra que duplica el mínimo que los científicos ven necesario para preservar la diversidad genética para la supervivencia de una especie.\nEn verano de 2021, los pandas se convirtieron según propagó el Gobierno chino en un éxito de conservación. Las autoridades chinas anunciaron que el animal, cuya población salvaje casi se ha duplicado en los últimos 30 años gracias a los esfuerzos de recuperación impulsados por Pekín, ya no está en peligro de extinción.\nSin embargo, un estudio de los efectos del cambio climático en el bambú - que representa un 99 por ciento de la dieta de los pandas -, alertó sobre que la tolerancia de los pandas y de su dieta a las variaciones de temperatura y precipitaciones es mucho más alta de lo que se pensaba.\nPor tanto, los expertos alertan sobre la fragilidad de la situación de estos mamíferos, que aún no se han librado de las consecuencias de la deforestación y la ruptura de su hábitat, que limita a los pandas salvajes a menos de un uno por cierto de su territorio, mientras nuevas amenazas aparecen derivadas del cambio climático. ',
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
  'assets/articulos/panda1.jpg',
  'assets/articulos/panda2.jpg',
  'assets/articulos/panda3.jpg',
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
