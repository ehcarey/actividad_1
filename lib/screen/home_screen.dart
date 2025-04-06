import 'package:flutter/material.dart';
import 'package:actividad_1/screen/car_list_screen.dart';
import 'package:actividad_1/screen/scanner_screen.dart';

class HomeScreen extends StatelessWidget {
  final String token;
  const HomeScreen({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: Icon(Icons.list),
              label: Text('Ver mis Carros'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CarListScreen(token: token),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.qr_code_scanner),
              label: Text('Escanear Código QR'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ScannerScreen(token: token),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
