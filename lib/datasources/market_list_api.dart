import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MarketApi {
  final Dio _dio;

  MarketApi(this._dio);

  Future<List<Map<String, dynamic>>> getListOfMarkets(
      {double? latitude, double? longitude}) async {
    try {
      final response = await _dio.get(
        'https://api.openpay.mx/stores?latitud=$latitude&longitud=$longitude&kilometers=1.5&amount=4000',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': dotenv.env['API_KEY'],
          },
        ),
      );

      final List<Map<String, dynamic>> markets =
          List<Map<String, dynamic>>.from(response.data);
      return markets;
    } catch (error) {
      throw Exception('Error al obtener la lista de Markets: $error');
    }
  }
}
