import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenPayApi {
  final Dio _dio;

  OpenPayApi(this._dio);

  Future<void> createUser(Map<String, dynamic> userData) async {
    try {
      final response = await _dio.post(
        'https://sandbox-api.openpay.mx/v1/mur2pss0enug2z7k4zlr/customers', // URL Create Customers
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': dotenv.env['API_KEY'],
            //asdasdasdasdasdasdasdasdasdasdasd
          },
        ),
        data: userData,
      );

      // Manejar la respuesta según la necesidad
      print('Respuesta del servidor: ${response.data}');
    } catch (error) {
      // Manejar errores
      print('Error en la solicitud: $error');
      throw Exception('Error en la solicitud: $error');
    }
  }

  Future<List<Map<String, dynamic>>> getListOfClients() async {
    try {
      final response = await _dio.get(
        'https://sandbox-api.openpay.mx/v1/mur2pss0enug2z7k4zlr/customers', // URL Get List of Customers
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': dotenv.env['API_KEY'],
          },
        ),
      );

      // Manejar la respuesta según la necesidad
      final List<Map<String, dynamic>> clients =
          List<Map<String, dynamic>>.from(response.data);
      return clients;
    } catch (error) {
      // Manejar errores
      print('Error al obtener la lista de clientes: $error');
      throw Exception('Error al obtener la lista de clientes: $error');
    }
  }
  
  Future<void> deleteUser(String id) async {
    try {
      final response = await _dio.delete(
        'https://sandbox-api.openpay.mx/v1/mur2pss0enug2z7k4zlr/customers/$id',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': dotenv.env['API_KEY'],
          },
        ),
      );

      // Manejar la respuesta según la necesidad
      print('Respuesta del servidor (eliminar usuario): ${response.data}');
    } catch (error) {
      // Manejar errores
      print('Error en la solicitud (eliminar usuario): $error');
      throw Exception('Error en la solicitud (eliminar usuario): $error');
    }
  }
}
