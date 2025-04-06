import 'package:flutter/material.dart';
import 'package:actividad_1/services/car_service.dart';
import 'package:actividad_1/widgets/carros.dart';

class CarListScreen extends StatefulWidget {
  final String token;
  const CarListScreen({Key? key, required this.token}) : super(key: key);

  @override
  _CarListScreenState createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  final CarService _carService = CarService();
  late Future<List<Car>> _carsFuture;

  @override
  void initState() {
    super.initState();
    _loadCars();
  }

  void _loadCars() {
    setState(() {
      _carsFuture = _carService.getCars(widget.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Vehículos'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadCars,
          ),
        ],
      ),
      body: FutureBuilder<List<Car>>(
        future: _carsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 50, color: Colors.red),
                  SizedBox(height: 20),
                  Text('Error al cargar vehículos', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  ElevatedButton(onPressed: _loadCars, child: Text('Reintentar')),
                ],
              ),
            );
          }

          final cars = snapshot.data ?? [];

          if (cars.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.directions_car, size: 50, color: Colors.blue),
                  SizedBox(height: 20),
                  Text('No tienes vehículos registrados', style: TextStyle(fontSize: 18)),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: cars.length,
            itemBuilder: (context, index) {
              final car = cars[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Icon(Icons.directions_car, size: 40, color: Colors.blue),
                  title: Text('${car.marca} ${car.modelo}'),
                  subtitle: Text('Matrícula: ${car.matricula}'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
