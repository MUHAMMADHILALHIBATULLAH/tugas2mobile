import 'dart:convert';
import 'package:tugas/models/maroon.dart';
import 'package:http/http.dart' as http;

class MaroonService {
  static const _baseUrl = 'https://prak-labkom-mobpro.000webhostapp.com/api/maroons';


  static Future<List<Maroon>> readMaroons() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      return data.map((maroonJson) => Maroon.fromJson(maroonJson)).toList();
    } else {
      throw Exception('Failed to read maroons');
    }
  }
}
