import 'package:biomovil/app_styles.dart';
import 'package:biomovil/size_config.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:audioplayers/audioplayers.dart';

AudioPlayer audioPlayer = AudioPlayer();

class AnimalesDetalles extends StatelessWidget {
  const AnimalesDetalles({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kLightWhite,
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 50,
              child: Stack(
                children: [
                  const FullScreenSlider(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 40,
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
                        vertical: 60,
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
                            padding: const EdgeInsets.all(8),
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
                            padding: const EdgeInsets.all(8),
                            child: SvgPicture.asset('assets/home_selected_icon.svg'
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
            onPressed: () {
//              playAudio(); // Llama al método playAudio cuando se presiona el botón
            },
            child: const Text("Reproducir Audio"),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: kPaddingHorizontal,
              ),
              transform: Matrix4.translationValues(0, -14, 0),
              child: Text(
                'Tucan',
                style: kPoppinsBold.copyWith(
                  color:kDarkBlue,
                  fontSize: SizeConfig.blockSizeHorizontal! * 7,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: kPaddingHorizontal,
                vertical: 16,
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
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 13,
                    backgroundColor: kBlue,
                    backgroundImage: AssetImage(
                      'assets/icono-tucan.jpg',
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal! * 2.5,
                  ),
                  Text(
                    'Nombre cientifico peso altura',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: kPoppinsRegular.copyWith(
                      color: kGrey,
                      fontSize: SizeConfig.blockSizeHorizontal! * 3,
                    ),
                  ),
              ]),
            ),
            Padding(
              padding:const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis enim lobortis scelerisque fermentum dui faucibus. Aliquet eget sit amet tellus cras adipiscing enim eu turpis. Dolor sit amet consectetur adipiscing elit ut aliquam. Tellus rutrum tellus pellentesque eu. Tincidunt dui ut ornare lectus sit. Urna nunc id cursus metus aliquam eleifend mi. Aliquet risus feugiat in ante metus dictum at tempor. Congue nisi vitae suscipit tellus mauris a diam. Ac felis donec et odio pellentesque.\n\nFringilla est ullamcorper eget nulla. Vulputate enim nulla aliquet porttitor lacus luctus accumsan tortor. Id leo in vitae turpis. Sit amet dictum sit amet justo donec enim diam vulputate. Sapien pellentesque habitant morbi tristique senectus et netus. Nunc sed augue lacus viverra vitae congue. A erat nam at lectus. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Faucibus et molestie ac feugiat sed lectus vestibulum mattis. Quisque egestas diam in arcu cursus euismod quis. Enim sed faucibus turpis in eu mi. Ullamcorper sit amet risus nullam eget. Est ante in nibh mauris cursus mattis molestie a iaculis. Ullamcorper sit amet risus nullam. Etiam dignissim diam quis enim lobortis scelerisque. Et odio pellentesque diam volutpat.',
                style: kPoppinsMedium.copyWith(
                  fontSize: SizeConfig.blockSizeHorizontal! * 4,
                  color: kDarkBlue,
                ),
              ),
            )
          ]),
      ),
    );
  }
}

//void playAudio() async {
//  int result = await audioPlayer.play(" URL_DEL_ARCHIVO_DE_AUDIO.mp3");
//  if (result == 1) {
//    // La reproducción del audio se inició con éxito
//    print('Reproduciendo audio');
//  }
//}

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
            height: SizeConfig.blockSizeVertical!*50,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            onPageChanged: (index, reason){
              setState(() {
                _current = index;
              });
            },
            initialPage: _current,
          ),
          items: imageList.map((item) => Center(
            child: Image.asset(
              item,
              fit: BoxFit.cover,
              height: SizeConfig.blockSizeVertical!*50,
              width: double.infinity,
              ),
            ),
          ).toList(),
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