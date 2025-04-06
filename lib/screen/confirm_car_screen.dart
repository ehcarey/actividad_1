import 'package:flutter/material.dart';
import 'package:actividad_1/widgets/carros.dart';

class ConfirmCarScreen extends StatelessWidget {
  final Car car;
  const ConfirmCarScreen({Key? key, required this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Confirmar Carro')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.electric_car, size: 100, color: Colors.green),
            SizedBox(height: 24),
            Text(
              '¿Desea tomar el carro ${car.matricula}?',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              icon: Icon(Icons.check),
              label: Text('Sí, tomar carro'),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Carro ${car.matricula} tomado')),
                );
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
            SizedBox(height: 16),
            OutlinedButton.icon(
              icon: Icon(Icons.cancel),
              label: Text('No'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
