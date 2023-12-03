import 'package:openpay_flutter/datasources/openpay_api.dart';

abstract class UserRepository {
  Future<void> createUser(Map<String, dynamic> userData);
  Future<List<Map<String, dynamic>>> getListOfClients();
  Future<void> deleteUser(String id);
  Future<void> editUser(String id, Map<String, dynamic> userData);
}

class UserRepositoryImpl implements UserRepository {
  final OpenPayApi apiClient;

  UserRepositoryImpl(this.apiClient);

  //Llamada para la creacion de un Cliente
  @override
  Future<void> createUser(Map<String, dynamic> userData) async {
    try {
      await apiClient.createUser(userData);
    } catch (error) {
      throw Exception('Error al crear el Cliente: $error');
    }
  }

  //Llamada para la obtencion de la lista de Clientes
  @override
  Future<List<Map<String, dynamic>>> getListOfClients() async {
    try {
      final clients = await apiClient.getListOfClients();
      return clients;
    } catch (error) {
      throw Exception('Error al obtener la lista de clientes: $error');
    }
  }

  //Llamada para la eliminacion de un Cliente por su ID
  @override
  Future<void> deleteUser(String customerId) async {
    try {
      await apiClient.deleteUser(customerId);
    } catch (error) {
      throw Exception('Error al eliminar el Cliente: $error');
    }
  }

  //Llamada para la modificacion de un Cliente por su ID
  @override
  Future<void> editUser(String id, Map<String, dynamic> userData) async {
    try {
      await apiClient.editUser(id, userData); 
    } catch (error) {
      throw Exception('Error al editar el Cliente: $error');
    }
  }
}
