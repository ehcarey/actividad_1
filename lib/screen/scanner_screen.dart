import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:actividad_1/services/car_service.dart';
import 'package:actividad_1/screen/confirm_car_screen.dart';



class ScannerScreen extends StatefulWidget {
  final String token;
  const ScannerScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  final _carService = CarService();
  bool _isProcessing = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) async {
      if (_isProcessing) return;

      setState(() => _isProcessing = true);

      try {
        final car = await _carService.getCarByQRCode(widget.token, scanData.code!);
        if (!mounted) return;

        controller.pauseCamera();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ConfirmCarScreen(car: car),
          ),
        ).then((_) {
          controller.resumeCamera();
          setState(() => _isProcessing = false);
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Código inválido o carro no encontrado')),
        );
        setState(() => _isProcessing = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Escáner QR')),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.green,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 250,
        ),
      ),
    );
  }
}
