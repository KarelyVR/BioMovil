// ignore_for_file: library_private_types_in_public_api

import 'package:biomovil/pantalla_ajustes/ajustes.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(const Comentarios());

class Comentarios extends StatelessWidget {
  const Comentarios({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FeedbackScreen(),
    );
  }
}

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  Future<void> _onBackPressed() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const Ajustes()),
    );
  }

  sendEmail() async {
    String username = 'karubi.jd@gmail.com';
    String password = 'pubk oiav hegg fqrf';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'BiomovilApp')
      ..recipients.add(emailController.text) // Usar la dirección del usuario
      ..subject = 'Comentario o Sugerencia'
      ..text = 'Se adjunta el siguiente texto:'
      ..html = '<h2>Hemos recibido su comentario</h2>\n<h3>Agradecemos todos sus comentarios sobre nuestra aplicacion o sobre el zoologico</h3>\n<h4>Ayudanos a mejorar</h4>\n<h4>Se recibio su siguiente comentario:</h4><p>\n\n${feedbackController.text}';

      // Verifica si los campos de nombre y dirección están llenos
    if (emailController.text.isNotEmpty && feedbackController.text.isNotEmpty) {

      try {
        final sendReport = await send(message, smtpServer);
        Fluttertoast.showToast(
          msg: 'Mensaje enviado: $sendReport',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      } on MailerException catch (e) {
        Fluttertoast.showToast(
          msg: 'El mensaje no se envió. ${e.toString()}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        for (var p in e.problems) {
          print(p.code);
          Fluttertoast.showToast(
            msg: 'Problema: ${p.code}: ${p.msg}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        }
      }
    } else {
      // Muestra un mensaje de error si algun campo está vacío
      Fluttertoast.showToast(
        msg: 'Por favor, completa todos los campos.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
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
              'Comentarios o sugerencias',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                _onBackPressed();
              },
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Déjanos tus comentarios o sugerencias:',
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 10.0),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10.0),
                KeyboardVisibilityBuilder(
                  builder: (context, isKeyboardVisible) {
                    return TextField(
                      controller: feedbackController,
                      maxLines: 7,
                      decoration: const InputDecoration(
                        labelText: 'Escribe aquí...',
                        border: OutlineInputBorder(),
                      ),
                    );
                  }
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    sendEmail();
                  },
                  child: const Text('Enviar'),
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    feedbackController.dispose();
    super.dispose();
  }
}
