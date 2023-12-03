import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenPayApi {
  final Dio _dio;

  OpenPayApi(this._dio);

  //Crear cliente nuevo
  Future<void> createUser(Map<String, dynamic> userData) async {
    try {
      await _dio.post(
        'https://sandbox-api.openpay.mx/v1/mur2pss0enug2z7k4zlr/customers', 
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': dotenv.env['API_KEY'],
          },
        ),
        data: userData,
      );
    } catch (error) {
      throw Exception('Error en la solicitud: $error');
    }
  }

  //Obtener Lista de Clientes
  Future<List<Map<String, dynamic>>> getListOfClients() async {
    try {
      final response = await _dio.get(
        'https://sandbox-api.openpay.mx/v1/mur2pss0enug2z7k4zlr/customers',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': dotenv.env['API_KEY'],
          },
        ),
      );
      final List<Map<String, dynamic>> clients =
          List<Map<String, dynamic>>.from(response.data);
      return clients;
    } catch (error) {
      throw Exception('Error al obtener la lista de clientes: $error');
    }
  }
  
  //Eliminar Cliente por ID
  Future<void> deleteUser(String id) async {
    try {
      await _dio.delete(
        'https://sandbox-api.openpay.mx/v1/mur2pss0enug2z7k4zlr/customers/$id',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': dotenv.env['API_KEY'],
          },
        ),
      );
    } catch (error) {
      throw Exception('Error en la solicitud (eliminar Cliente): $error');
    }
  }

  //Editar Cliente por ID  
  Future<void> editUser(String id, Map<String, dynamic> userData) async {
    try {
      await _dio.put(
        'https://sandbox-api.openpay.mx/v1/mur2pss0enug2z7k4zlr/customers/$id',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': dotenv.env['API_KEY'],
          },
        ),
        data: userData,
      );
    } catch (error) {
      throw Exception('Error en la solicitud (editar Cliente): $error');
    }
  }
}


