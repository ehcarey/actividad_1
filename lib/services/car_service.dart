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
      List<dynamic> carsJson = jsonDecode(response.body);
      return carsJson.map((json) => Car.fromJson(json)).toList();
    }
    return [];
  }
}
