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
  List<Car> _availableCars = [
    Car(matricula: 'TESLA001', modelo: 'Model S', marca: 'Tesla'),
    Car(matricula: 'AUDI001', modelo: 'e-tron', marca: 'Audi'),
    Car(matricula: 'NISSAN001', modelo: 'Leaf', marca: 'Nissan'),
    Car(matricula: 'BMW001', modelo: 'i4', marca: 'BMW'),
    Car(matricula: 'FORD001', modelo: 'Mustang Mach-E', marca: 'Ford'),
  ];

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

  void _addCar() async {
    final newCar = await showDialog<Car>(
      context: context,
      builder: (context) => AddCarDialog(availableCars: _availableCars),
    );

    if (newCar != null) {
      try {
        await _carService.addCar(widget.token, newCar);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Vehículo agregado exitosamente')),
        );
        _loadCars();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mis Vehículos'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.garage)), 
              Tab(icon: Icon(Icons.local_offer)),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _loadCars,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _addCar,
        ),
        body: TabBarView(
          children: [
            // Pestaña de Mis Vehículos
            FutureBuilder<List<Car>>(
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
                        Text(
                          'Error al cargar vehículos',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _loadCars,
                          child: Text('Reintentar'),
                        ),
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
                        Text(
                          'No tienes vehículos registrados',
                          style: TextStyle(fontSize: 18),
                        ),
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

            // Pestaña de Vehículos Disponibles
            ListView.builder(
              itemCount: _availableCars.length,
              itemBuilder: (context, index) {
                final car = _availableCars[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(Icons.electric_car, size: 40, color: Colors.green),
                    title: Text('${car.marca} ${car.modelo}'),
                    subtitle: Text('Matrícula: ${car.matricula}'),
                    trailing: Icon(Icons.info_outline),
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

class AddCarDialog extends StatefulWidget {
  final List<Car> availableCars;

  const AddCarDialog({Key? key, required this.availableCars}) : super(key: key);

  @override
  _AddCarDialogState createState() => _AddCarDialogState();
}

class _AddCarDialogState extends State<AddCarDialog> {
  String? _selectedCar;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Agregar Vehículo'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedCar,
              decoration: InputDecoration(
                labelText: 'Seleccione un vehículo',
                border: OutlineInputBorder(),
              ),
              items: widget.availableCars.map((car) {
                return DropdownMenuItem<String>(
                  value: '${car.marca} ${car.modelo}',
                  child: Text('${car.marca} ${car.modelo}'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCar = value;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: _selectedCar == null 
              ? null 
              : () {
                  final selected = widget.availableCars.firstWhere(
                    (car) => '${car.marca} ${car.modelo}' == _selectedCar);
                  Navigator.pop(context, selected);
                },
          child: Text('Agregar'),
        ),
      ],
    );
  }
}