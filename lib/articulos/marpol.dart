import 'menu_articulos.dart';
import 'package:biomovil/themes/app_styles.dart';
import 'package:biomovil/themes/size_config.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:biomovil/animales/menu_desplegable.dart' as menu;


class Contaminacion extends StatelessWidget {
  Contaminacion({super.key});

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
                        'Contaminación del mar y las costas',
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
                            'Una contaminación prolongada puede afectar a los ecosistemas marinos y costeros y hacer peligrar los medios de vida de comunidades enteras. El OIEA, mediante la aplicación de técnicas nucleares e isotópicas de vanguardia, ayuda a los Estados Miembros a vigilar con exactitud la contaminación, reducir al mínimo las consecuencias de los incidentes y mitigar sus efectos en la población local.\nSe estima que el 80 % de los contaminantes presentes en el medio marino proceden de la tierra. Algunas sustancias peligrosas, como los metales pesados tóxicos, los compuestos orgánicos persistentes (como los plaguicidas y los productos químicos industriales), los hidrocarburos y las sustancias radiactivas procedentes de actividades industriales, agrícolas, municipales y mineras, terminan pasando al medio marino por medio de las aguas superficiales y subterráneas.\nA fin de prestar asistencia a los Estados Miembros para hacer frente a la contaminación del mar y las costas, el OIEA ha desarrollado una serie de recursos y técnicas científicos que ayudan a los encargados de adoptar decisiones a proteger el medio marino. El Organismo cuenta con laboratorios para el medio ambiente en Mónaco y Seibersdorf (Austria) en los que se aplican técnicas nucleares e isotópicas para estudiar los procesos de contaminación y determinar el origen de los contaminantes.\nLos contaminantes que acaban en las aguas costeras pueden acumularse en los organismos marinos a través de la cadena alimentaria, lo que deteriora la resiliencia del ecosistema y supone un peligro para la salud humana de consumirse pescados y mariscos contaminados. En los últimos años también han aumentado los casos de floraciones de algas nocivas, que pueden producir toxinas que ocasionan enfermedades de origen alimentario como la intoxicación paralizante por mariscos y la intoxicación por ciguatera en pescados, que pueden ser letales. Estos casos afectan a la pesca, la acuicultura, el turismo y el uso del agua de bebida y de recreo.\nEl OIEA, por medio de sus laboratorios para el medio ambiente, desempeña un papel clave en la investigación y la capacitación sobre la manera de detectar la presencia de contaminantes y biotoxinas peligrosos en los alimentos de origen marino, por ejemplo, mediante el análisis de unión de radioligando, procedimiento analítico empleado para detectar toxinas durante la floración de algas nocivas. Asimismo, en el marco de una asociación con la Organización Regional para la Protección del Medio Marino, uno de los programas de mares regionales del Programa de las Naciones Unidas para el Medio Ambiente, se analizaron en los Laboratorios del OIEA para el Medio Ambiente, sitos en Mónaco, muestras de ostras y sedimentos marinos del Golfo Pérsico para determinar los niveles de radionucleidos, oligoelementos, contaminantes orgánicos y biotoxinas relacionados con la floración de algas nocivas.',
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
  'assets/articulos/contaminacion1.jpg',
  'assets/articulos/contaminacion2.jpg',
  'assets/articulos/contaminacion3.jpg',
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
