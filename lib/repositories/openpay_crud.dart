import 'package:openpay_flutter/datasources/openpay_api.dart';

abstract class UserRepository {
  Future<void> createUser(Map<String, dynamic> userData);
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
}
