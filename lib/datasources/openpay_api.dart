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
}
