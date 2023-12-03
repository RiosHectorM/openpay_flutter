import 'package:openpay_flutter/datasources/openpay_api.dart';

abstract class UserRepository {
  Future<void> createUser(Map<String, dynamic> userData);
  Future<List<Map<String, dynamic>>> getListOfClients();
  Future<void> deleteUser(String id);
}

class UserRepositoryImpl implements UserRepository {
  final OpenPayApi apiClient;

  UserRepositoryImpl(this.apiClient);

  @override
  Future<void> createUser(Map<String, dynamic> userData) async {
    try {
      await apiClient.createUser(userData);
    } catch (error) {
      throw Exception('Error al crear el usuario: $error');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getListOfClients() async {
    try {
      final clients = await apiClient.getListOfClients();
      return clients;
    } catch (error) {
      throw Exception('Error al obtener la lista de clientes: $error');
    }
  }

  @override
  Future<void> deleteUser(String customerId) async {
    try {
      await apiClient.deleteUser(customerId);
    } catch (error) {
      throw Exception('Error al eliminar el usuario: $error');
    }
  }
}
