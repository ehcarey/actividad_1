import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:actividad_1/widgets/carros.dart';
import 'package:actividad_1/services/auth_service.dart';


class CarService {
  static const String _baseUrl = 'https://carros-electricos.wiremockapi.cloud';

  Future<List<Car>> getCars(String token) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/carros'),
      headers: {'Authentication': token},
    );

   if (response.statusCode == 200) {
      try {
        List<dynamic> carsJson = jsonDecode(response.body);
        _cars = carsJson.map((json) => Car.fromJson(json)).toList();
        return _cars;
      } catch (e) {
        print('Error al convertir respuesta: $e');
      }
    }

    // Datos ficticios si la API falla
    _cars = [
      Car(id: 'ABC123', modelo: 'Model S', marca: 'a'),
      Car(id: 'XYZ789', modelo: 'PICANT', marca: 'Ford'),
      Car(id: 'LMN456', modelo: 'iX3', marca: 'BMW'),
    ];
    return _cars;
  }

  // Método para agregar un nuevo vehículo y actualizar la lista
  Future<void> addCar(String token, Car newCar) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/carros'),
      headers: {
        'Authentication': token,
        'Content-Type': 'application/json',
      },
      body: jsonEncode(newCar.toJson()),
    );

    if (response.statusCode == 201) {
      _cars.add(newCar); // Agregar localmente para actualizar la UI
    } else {
      print('Error al agregar vehículo: ${response.body}');
    }
  }
}

