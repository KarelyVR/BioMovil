// ignore_for_file: library_private_types_in_public_api

import 'package:biomovil/pantalla_ajustes/ayuda.dart';
import 'package:biomovil/pantalla_ajustes/comentarios.dart';
import 'package:biomovil/pantalla_ajustes/terminos_condiciones.dart';
import 'package:biomovil/principal/pagina_principal.dart';
import 'package:flutter/material.dart';
import 'package:biomovil/themes/theme_provider.dart';
import 'package:biomovil/themes/app_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:provider/provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: Ajustes(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

// class Ajustes extends StatefulWidget {
//   const Ajustes({super.key});

//   @override
//   _MyAppState createState() => _MyAppState();
// }

class Ajustes extends HookConsumerWidget {
  const Ajustes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    bool notificationsEnabled = false;
    // bool locationAccessEnabled = false;
    // bool darkModeEnabled = false;

    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:
          appThemeState.isDarkModeEnable ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
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
            'Ajustes',
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
                  builder: (context) => const PaginaPrincipal(),
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
        body: Column(
          children: [
            const SizedBox(height: 16.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView(
                  children: [
                    ListTile(
                      title: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 50.0),
                            child: Text(
                              'Notificaciones',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          const Spacer(),
                          Switch(
                            value: notificationsEnabled,
                            onChanged: (value) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Función en desarrollo'),
                                    content: const Text(
                                        'La función de Notificaciones actualmente se encuentra en desarrollo.'),
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
                            },
                            activeColor: Colors.green,
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 194, 189, 189),
                      thickness: 2.0,
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text(
                              'Acceso a ubicación',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          const Spacer(),
                          Switch(
                            value: notificationsEnabled,
                            onChanged: (value) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Función en desarrollo'),
                                    content: const Text(
                                        'La función de Acceso a Ubicación actualmente se encuentra en desarrollo.'),
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
                            },
                            activeColor: Colors.green,
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 194, 189, 189),
                      thickness: 2.0,
                    ),
                    //modo oscuro
                    // ListTile(
                    //   title: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.only(right: 16.0),
                    //         child: Text(
                    //           'Modo oscuro',
                    //           style: Theme.of(context)
                    //               .textTheme
                    //               .bodyMedium
                    //               ?.copyWith(
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //         ),
                    //       ),
                    //       const Spacer(),
                    //       const DarkModeSwitch(),
                    //     ],
                    //   ),
                    // ),
                    // const Divider(
                    //   color: Color.fromARGB(255, 194, 189, 189),
                    //   thickness: 2.0,
                    // ),
                    ListTile(
                      title: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text(
                              'Comentarios o sugerencias',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Comentarios(),
                          ),
                        );
                      },
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 194, 189, 189),
                      thickness: 2.0,
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text(
                              'Ayuda',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Ayuda(),
                          ),
                        );
                      },
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 194, 189, 189),
                      thickness: 2.0,
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text(
                              'Términos y condiciones',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TerminosCondiciones(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Contáctanos:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialMediaIcon(
                        icon: Icons.facebook,
                        iconColor: Colors.blue,
                        label: 'Bioparque',
                      ),
                      SizedBox(width: 15.0),
                      SocialMediaIcon(
                        icon: Icons.phone,
                        label: '55 5089 9990',
                        iconColor: Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SocialMediaIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;

  const SocialMediaIcon(
      {super.key,
      required this.icon,
      required this.label,
      this.iconColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        const SizedBox(height: 4.0),
        Text(label),
      ],
    );
  }
}
