import 'package:biomovil/pantalla_ajustes.dart/ajustes.dart';
import 'package:flutter/material.dart';

void main() => runApp(Comentarios());

class Comentarios extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FeedbackScreen(),
    );
  }
}

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();
  String _confirmationMessage = '';

  Future<void> _onBackPressed() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Ajustes()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            backgroundColor: Colors.green,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            title: const Text(
              'Comentarios o sugerencias',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
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
          child: Column(
            children: [
              const Text(
                'Déjanos tus comentarios o sugerencias:',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: _feedbackController,
                maxLines: 7,
                decoration: const InputDecoration(
                  hintText: 'Escribe aquí...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Future.delayed(const Duration(seconds: 2), () {
                    setState(() {
                      _confirmationMessage = 'Se ha enviado exitosamente';
                    });
                  });
                },
                child: const Text('Enviar'),
              ),
              const SizedBox(height: 10.0),
              Text(
                _confirmationMessage,
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }
}
