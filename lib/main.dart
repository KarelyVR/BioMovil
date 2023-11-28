// ignore_for_file: use_build_context_synchronously
import 'package:biomovil/principal/pagina_principal.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;

  runApp(
    ProviderScope(
      child: MyApp(showHome: showHome),
    ),
  );
}
class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({Key? key,
  required this.showHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
    initialRoute: '/', //flutter mostrara primero la ruta inicial
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.teal,
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontSize: 64,
          color: Colors.black26,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.teal.shade700,
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    home: const OnboardingPage(),
  );
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose(){
    controller.dispose();

    super.dispose();
  }

  Widget buildPage({
    required Color color,
    required String urlImage,
    required String title,
    required String subtitle,
  }) => 
    Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            urlImage,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          const SizedBox(height: 64),
          Text(
            title,
            style: TextStyle(
              color: Colors.teal.shade700,
              fontSize: 32,
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Text(
              subtitle,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      padding: const EdgeInsets.only(bottom: 80),
      child: PageView(
        controller: controller,
        onPageChanged: (index) {
          setState(() => isLastPage = index == 2);
        },
        children: [
          buildPage(
            color: Colors.green.shade100,
            urlImage: 'assets/page1.png',
            title:'Recorridos',
            subtitle: 'Visita los mejores lugares con tu familia',
          ),
          buildPage(
            color: Colors.blue.shade100,
            urlImage: 'assets/page2.png',
            title:'Muchos Animales',
            subtitle: 'Conoce a todos los animales del parque',
          ),
          buildPage(
            color: Colors.orange.shade100,
            urlImage: 'assets/page3.png',
            title:'Escaner de QR',
            subtitle: 'Escanea los codigos QR que veas por nuestro parque para encontrar sorpresas',
          ),
        ],
      ),
    ),
    bottomSheet: isLastPage //indica si se llego al final de las pantallas para colocar un boton
      ? TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
            ),
            foregroundColor: Colors.white,
            backgroundColor: Colors.teal.shade700,
            minimumSize: const Size.fromHeight(80)
          ),
          child: const Text(
            'Comenzar',
            style: TextStyle(fontSize: 24),
          ),
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            prefs.setBool('showHome', true);

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const PaginaPrincipal()), //lleva directo a la pagina principal
            );
          },
        )
      : Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => controller.jumpToPage(2), 
              child: const Text('SALTAR')
            ),
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: WormEffect(
                  spacing: 16,
                  dotColor: Colors.black26,
                  activeDotColor: Colors.teal.shade700,
                ),
                onDotClicked: (index) => controller.animateToPage(
                  index, 
                  duration: const Duration(milliseconds: 500), 
                  curve: Curves.easeIn),
              ),
            ),
            TextButton(
              onPressed: () => controller.nextPage(
                duration: const Duration(
                  milliseconds: 500), 
                curve: Curves.easeInOut), 
              child: const Text('SIGUIENTE')
            ),
          ],
        ),
      ),
  );
}
