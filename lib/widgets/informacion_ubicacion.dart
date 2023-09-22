// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class InformacionUbicacion extends StatefulWidget {
  const InformacionUbicacion({super.key});

  @override
  State<InformacionUbicacion> createState() => _InformacionUbicacionState();
}

class _InformacionUbicacionState extends State<InformacionUbicacion> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Theme.of(context).backgroundColor,
        boxShadow: [
          BoxShadow(
            spreadRadius: 0,
            blurRadius: 0,
            offset: const Offset(0, 0),
            color: Theme.of(context).shadowColor
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'animal',
                style:Theme.of(context).
                textTheme.bodySmall,),
              Text(
                'encuentralo ahora',
                style:Theme.of(context).
                textTheme.bodySmall,),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'junto al restaurante osos',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                'cerca del estanque de los patos',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'Abierto',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}