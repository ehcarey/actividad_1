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
  Car(matricula: 'AAA001', modelo: 'Model S', marca: 'Tesla'),
  Car(matricula: 'BBB002', modelo: 'Leaf', marca: 'Nissan'),
  Car(matricula: 'CCC003', modelo: 'i3', marca: 'BMW'),
  Car(matricula: 'DDD004', modelo: 'e-tron', marca: 'Audi'),
  Car(matricula: 'EEE005', modelo: 'Mustang Mach-E', marca: 'Ford'),
  Car(matricula: 'FFF006', modelo: 'Bolt EV', marca: 'Chevrolet'),
  Car(matricula: 'GGG007', modelo: 'ID.4', marca: 'Volkswagen'),
  Car(matricula: 'HHH008', modelo: 'Kona EV', marca: 'Hyundai'),
  Car(matricula: 'III009', modelo: 'Soul EV', marca: 'Kia'),
  Car(matricula: 'JJJ010', modelo: 'Polestar 2', marca: 'Polestar'),
  Car(matricula: 'KKK011', modelo: 'Taycan', marca: 'Porsche'),
  Car(matricula: 'LLL012', modelo: 'EQC', marca: 'Mercedes-Benz'),
  Car(matricula: 'MMM013', modelo: 'XC40 Recharge', marca: 'Volvo'),
  Car(matricula: 'NNN014', modelo: 'Ariya', marca: 'Nissan'),
  Car(matricula: 'OOO015', modelo: 'Lucid Air', marca: 'Lucid'),
  Car(matricula: 'PPP016', modelo: 'Cybertruck', marca: 'Tesla'),
  Car(matricula: 'QQQ017', modelo: 'Hummer EV', marca: 'GMC'),
  Car(matricula: 'RRR018', modelo: 'F-150 Lightning', marca: 'Ford'),
  Car(matricula: 'SSS019', modelo: 'iX', marca: 'BMW'),
  Car(matricula: 'TTT020', modelo: 'Zoe', marca: 'Renault'),
  Car(matricula: 'UUU021', modelo: 'EV6', marca: 'Kia'),
  Car(matricula: 'VVV022', modelo: 'Lyriq', marca: 'Cadillac'),
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
  Future<Car> getCarByQRCode(String token, String codigoQR) async {
  final url = Uri.parse('https://67f7d1812466325443eadd17.mockapi.io/carros/$codigoQR');

  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    return Car.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Carro no encontrado');
  }
}

}