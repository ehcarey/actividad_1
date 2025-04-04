import 'package:flutter/material.dart';
import 'package:actividad_1/services/car_service.dart';
import 'package:actividad_1/widgets/carros.dart';

class CarListScreen extends StatefulWidget {
  final String token;
  CarListScreen({required this.token});

  @override
  _CarListScreenState createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  final _carService = CarService();
  late Future<List<Car>> _cars;

  @override
  void initState() {
    super.initState();
    _cars = _carService.getCars(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mis Autos')),
      body: FutureBuilder<List<Car>>(
        future: _cars,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al obtener los autos'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tienes autos registrados'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final car = snapshot.data![index];
              return ListTile(
                title: Text(car.modelo),
                subtitle: Text(car.marca),
              );
            },
          );
        },
      ),
    );
  }
}
