// // ignore_for_file: library_private_types_in_public_api, avoid_print

// import 'package:biomovil/principal/pagina_principal.dart';
// import 'package:flutter/material.dart';
// import 'package:biomovil/animales/menu_desplegable.dart' as menu;

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
  

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.green,
//           title: const Text('Lista Desplegable de Formulario'),
//         ),
//         body: const Center(
//           child: Recorridos(),
//         ),
//       ),
//     );
//   }
// }

// class Recorridos extends StatefulWidget {
//   const Recorridos({super.key});

//   @override
//   _RecorridosState createState() => _RecorridosState();
// }

// class _RecorridosState extends State<Recorridos> {
//   String selectedOption = ''; // Variable para almacenar la opción seleccionada
//   //La cantidad de "bool?" debe coincidir con la de checkbox y deben ir en incremento
//   bool? isCheckedOption1; // Variable para rastrear el estado del Checkbox 1
//   bool? isCheckedOption2; // Variable para rastrear el estado del Checkbox 2
//   bool? isCheckedOption3; // Variable para rastrear el estado del Checkbox 3
//   bool? isCheckedOption4; // Ya dió hueva escribir este comentario, pero se entiende la idea
//   bool? isCheckedOption5;
//   bool? isCheckedOption6;
//   bool? isCheckedOption7;
//   bool? isCheckedOption8;
//   bool? isCheckedOption9;

//   final List<String> menuItems = [
//     "Pagina principal",
//     "Animales",
//     "Codigo QR",
//     "Recorridos",
//     "Ajustes",
//   ];

//   final List<String> options = [
//     '',
//     '15 Minutos',
//     '30 Minutos',
//     '45 Minutos',
//     '1 Hora',
//     '1 hora y 30 Minutos',
//     '2 Horas',
//   ]; // Opciones para la lista desplegable

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         elevation: 0,
//         centerTitle: true,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(20.0),
//             bottomRight: Radius.circular(20.0),
//           ),
//         ),
//         title: const Text(
//           'Crea tu recorrido',
//           style: TextStyle(
//             fontSize: 20.0,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         leading: InkWell(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const PaginaPrincipal(),
//               ),
//             );
//           },
//           child: Container(
//             padding: const EdgeInsets.all(10),
//             child: const Icon(
//               Icons.arrow_back_ios_new,
//               size: 28,
//             ),
//           ),
//         ),
//         actions: [
//           Builder(
//             builder: (BuildContext context) {
//               return InkWell(
//                 onTap: () {
//                   // Abre el drawer (menú lateral derecho)
//                   Scaffold.of(context).openDrawer();
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.all(10),
//                   child: const Icon(
//                     Icons.sort_rounded,
//                     size: 28,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       drawer: const menu.NavigationDrawer(),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             children: <Widget>[
//               const Text(
//                 "Crea tu propio recorrido:",
//                 style: TextStyle(
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 40,),
//               DropdownButtonFormField<String>(
//                 value: selectedOption,
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     selectedOption = newValue!;
//                   });
//                 },
//                 items: options.map((String option) {
//                   return DropdownMenuItem<String>(
//                     value: option,
//                     child: Text(option),
//                   );
//                 }).toList(),
//                 decoration: const InputDecoration(
//                   labelText: 'Selecciona una opción',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               Row(
//                 children: <Widget>[
//                   const Expanded(
//                     child: Text(
//                       'Participarán niños en el recorrido?',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   Checkbox(
//                     value: isCheckedOption9 ?? false,
//                     onChanged: (value) {
//                       setState(() {
//                         isCheckedOption9 = value;
//                       });
//                     },
//                   ),
//                   const Text(
//                     'Sí', // Puedes personalizar este texto
//                     style: TextStyle(
//                       fontSize: 16, // Puedes ajustar el tamaño de fuente según tus preferencias
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 30),
//               //Estos son los checkbox
//               buildCheckbox('Leones', isCheckedOption1, (value) {
//                 setState(() {
//                   isCheckedOption1 = value;
//                 });
//               }),
//               buildCheckbox('Elefantes', isCheckedOption2, (value) {
//                 setState(() {
//                   isCheckedOption2 = value;
//                 });
//               }),
//               buildCheckbox('Monos', isCheckedOption3, (value) {
//                 setState(() {
//                   isCheckedOption3 = value;
//                 });
//               }),
//               buildCheckbox('Tigres', isCheckedOption4, (value) {
//                 setState(() {
//                   isCheckedOption3 = value;
//                 });
//               }),
//               buildCheckbox('Jirafas', isCheckedOption5, (value) {
//                 setState(() {
//                   isCheckedOption3 = value;
//                 });
//               }),
//               buildCheckbox('Rinocerontes', isCheckedOption6, (value) {
//                 setState(() {
//                   isCheckedOption3 = value;
//                 });
//               }),
//               buildCheckbox('Aves', isCheckedOption7, (value) {
//                 setState(() {
//                   isCheckedOption3 = value;
//                 });
//               }),
//               buildCheckbox('De Granja', isCheckedOption8, (value) {
//                 setState(() {
//                   isCheckedOption3 = value;
//                 });
//               }),
//               ElevatedButton(
//                 onPressed: () {
//                   // Mostrar la alerta al presionar el botón "Mostrar Alerta"
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         title: const Text('Accion no disponible'),
//                         content: const Text('Actualmente en desarrollo'),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               // Cerrar la alerta al presionar el botón "OK"
//                               Navigator.of(context).pop();
//                             },
//                             child: const Text('OK'),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//                 child: const Text('Buscar Recorrido'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildCheckbox(String label, bool? value, ValueChanged<bool?> onChanged) {
//     return Row(
//       children: <Widget>[
//         Checkbox(
//           value: value ?? false,
//           onChanged: onChanged,
//         ),
//         Text(label),
//       ],
//     );
//   }
// }