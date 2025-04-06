import 'package:flutter/material.dart';

import 'package:actividad_1/widgets/carros.dart';

class CarCard extends StatelessWidget {
  final Car car;
  const CarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(car.modelo),
        subtitle: Text(car.marca),
      ),
    );
  }
}
