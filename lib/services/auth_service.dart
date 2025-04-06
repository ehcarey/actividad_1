import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  String? _token;
  static const String _baseUrl = 'https://carros-electricos.wiremockapi.cloud';

  Future<bool> login(String username, String password) async {
    // Modo local para pruebas
    if (username == 'admin' && password == 'admin') {
      _token = 'token_local_admin';
      return true;
    }

    // Intenta login real contra la API
    final response = await http.post(
      Uri.parse('$_baseUrl/auth'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      _token = jsonDecode(response.body)['token'];
      return true;
    }

    return false;
  }

  String? get token => _token;
}
