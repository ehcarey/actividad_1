import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:actividad_1/widgets/carros.dart';

class CarService {
  static const String _baseUrl = 'https://carros-electricos.wiremockapi.cloud';
  
  Future<List<Car>> getCars(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/carros'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        List<dynamic> carsJson = jsonDecode(response.body);
        return carsJson.map((json) => Car.fromJson(json)).toList();
      } else {
        throw Exception('Error al obtener vehículos: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error en getCars: $e');
      // Datos ficticios si la API falla (solo para desarrollo)
      return [
        Car(matricula: 'ABC123', modelo: 'Model S', marca: 'Tesla'),
        Car(matricula: 'XYZ789', modelo: 'Mustang Mach-E', marca: 'Ford'),
        Car(matricula: 'LMN456', modelo: 'iX3', marca: 'BMW'),
      ];
    }
  }

  Future<void> addCar(String token, Car newCar) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/carros'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(newCar.toJson()),
      );

      if (response.statusCode != 201) {
        throw Exception('Error al agregar vehículo: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error en addCar: $e');
      rethrow;
    }
  }
}