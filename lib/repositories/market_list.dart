import 'package:openpay_flutter/datasources/market_list_api.dart';

abstract class MarketRepository {
  Future<List<Map<String, dynamic>>> getListOfMarkets({double? latitude, double? longitude});
}

class MarketRepositoryImpl implements MarketRepository {
  final MarketApi apiMarket;

  MarketRepositoryImpl(this.apiMarket);

  //Llamada para obtener lista de Sucursales
  @override
  Future<List<Map<String, dynamic>>> getListOfMarkets({double? latitude, double? longitude}) async {
    try {
      final markets = await apiMarket.getListOfMarkets(latitude: latitude, longitude: longitude);
      return markets;
    } catch (error) {
      throw Exception('Error al obtener la lista de clientes: $error');
    }
  }
}

