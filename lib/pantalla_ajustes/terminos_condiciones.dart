// ignore_for_file: library_private_types_in_public_api

import 'package:biomovil/pantalla_ajustes/ajustes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:biomovil/themes/theme_provider.dart';
import 'package:biomovil/themes/app_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: TerminosCondiciones(),
      ),
    ),
  );
}

class TerminosCondiciones extends HookConsumerWidget {
  const TerminosCondiciones({super.key});

  @override
  Widget build(BuildContext context,  WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    return MaterialApp(
      title: 'Términos y Condiciones',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: appThemeState.isDarkModeEnable ? ThemeMode.dark : ThemeMode.light,
      home: const TermsAndConditionsScreen(),
    );
  }
}

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  _TermsAndConditionsScreenState createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  bool acceptedTerms = false;

  final String termsAndConditionsText = '''
Bienvenido al Bioparque. Antes de ingresar y disfrutar de nuestras instalaciones, te solicitamos que leas y aceptes los siguientes términos y condiciones que rigen tu visita a nuestro bioparque:

**1. Entrada al Bioparque:**

- Al ingresar al bioparque, aceptas cumplir con todas las reglas y regulaciones establecidas por la administración.
- Los visitantes deben pagar la tarifa de entrada correspondiente, la cual puede variar según la edad y el tipo de visitante. Los niños menores de 3 años entran gratis.
- Los visitantes deben conservar su boleto de entrada durante toda la visita y presentarlo a solicitud del personal del bioparque.

**2. Comportamiento y Seguridad:**

- Se espera que todos los visitantes respeten a los animales y las instalaciones del bioparque. No está permitido arrojar objetos, molestar a los animales o dañar las instalaciones.
- Se prohíbe fumar, consumir alcohol, drogas o cualquier sustancia ilegal dentro del bioparque.
- Los padres o tutores son responsables de supervisar a los niños en todo momento.
- Mantén un volumen adecuado en tus dispositivos de audio y teléfonos móviles para no perturbar a otros visitantes y a los animales.
- Sigue las instrucciones del personal del bioparque en caso de evacuación o cualquier otra emergencia.

**3. Alimentos y Bebidas:**

- Está permitido llevar alimentos y bebidas no alcohólicas al bioparque, pero te pedimos que los consumas en las áreas designadas para picnic.
- Se ofrecen opciones de comida y bebida en los puntos de venta autorizados dentro del bioparque.

**4. Fotografía y Grabación:**

- Los visitantes pueden tomar fotografías y videos para uso personal. Sin embargo, se prohíbe el uso comercial o la venta de cualquier material audiovisual sin el consentimiento expreso del bioparque.
- No se permite el uso de drones o cualquier otro equipo de grabación aérea sin autorización previa.

**5. Mascotas:**

- No se permiten mascotas dentro del bioparque, excepto perros guía para personas con discapacidades.

**6. Cancelaciones y Reembolsos:**

- No se realizarán reembolsos por la compra de boletos de entrada, a menos que el bioparque cancele la visita debido a circunstancias excepcionales.

**7. Responsabilidad:**

- El bioparque no se hace responsable por lesiones, pérdidas o daños a la propiedad durante la visita.
- Los visitantes son responsables de sus pertenencias y deben mantenerlas seguras en todo momento.

**8. Modificaciones de los Términos y Condiciones:**

- El bioparque se reserva el derecho de modificar estos términos y condiciones en cualquier momento. Las modificaciones entrarán en vigor inmediatamente después de su publicación en el sitio web del bioparque.

**9. Cumplimiento de las Leyes y Regulaciones:**

- Los visitantes deben cumplir con todas las leyes y regulaciones aplicables durante su visita al bioparque.
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          title: const Text(
            'Terminos y Condiciones',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          leading: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Ajustes(),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 28,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MarkdownBody(
              data: termsAndConditionsText,
              styleSheet: MarkdownStyleSheet(
                h1: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                h2: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                h3: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                h4: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                h5: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                h6: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16.0),
            CheckboxListTile(
              title: Text(
                'Acepto los términos y condiciones',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
                ),
              value: acceptedTerms,
              onChanged: (value) {
                setState(() {
                  acceptedTerms = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading, 
              tileColor: Theme.of(context).checkboxTheme.fillColor?.resolve({}), 
              checkColor: Colors.white,
              activeColor: Colors.green,
              overlayColor: Theme.of(context).checkboxTheme.overlayColor,
            ),
            ElevatedButton(
              onPressed: () {
                if (acceptedTerms) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                    return AlertDialog(
                       title: const Text('Gracias'),
                         content: const Text('Los terminos y condiciones han sido aceptados.'),
                         actions: [
                         TextButton(
                          onPressed: () {
                             Navigator.of(context).pop();
                             },
                          child: const Text('OK'),
                          ),
                        ],
                    );
                    },
                   );
                  } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Acepta los términos y condiciones'),
                        content: const Text(
                            'Debes aceptar los términos y condiciones antes de continuar.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Continuar'),
            ),
          ],
        ),
      ),
    );
  }
}
