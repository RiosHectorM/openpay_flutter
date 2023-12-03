import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:openpay_flutter/repositories/openpay_crud.dart';
import 'package:openpay_flutter/datasources/openpay_api.dart';
import 'package:go_router/go_router.dart';


class ListClientsScreen extends StatefulWidget {
  final UserRepository userRepository = UserRepositoryImpl(OpenPayApi(Dio()));

  @override
  _ListClientsScreenState createState() => _ListClientsScreenState();
}

class _ListClientsScreenState extends State<ListClientsScreen> {
  List<Map<String, dynamic>> clients = [];

  @override
  void initState() {
    super.initState();
    fetchListOfClients();
  }

  Future<void> fetchListOfClients() async {
    try {
      final clientsList = await widget.userRepository.getListOfClients();
      setState(() {
        clients = clientsList;
      });
    } catch (error) {
      // Maneja el error según tus necesidades
      print('Error al obtener la lista de clientes: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Clientes'),
      ),
      body: clients.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: clients.length,
              itemBuilder: (context, index) {
                final client = clients[index];
                return ListTile(
                  title: Row(
                    children: [
                      Text(client['name'] ?? ''),
                      const Text(' '),
                      Text(client['last_name'] ?? ''),
                      const Spacer(flex: 1),
                      ElevatedButton(
                          onPressed: () {
                            // Acción cuando se presiona el botón "Editar"
                            print('Editar cliente: ${client['name']}');
                          },
                          child: const Icon(Icons.edit)),
                      const SizedBox(width: 4), // Espacio entre los botones
                      ElevatedButton(
                          onPressed: () async {

                            try {
                              await widget.userRepository.deleteUser(client['id']);
                              // Mostrar SnackBar de éxito
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Usuario Eliminado exitosamente'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              await fetchListOfClients();
                            } catch (error) {
                              // Mostrar SnackBar de error
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error al Eliminar el usuario: $error'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          child: const Icon(Icons.delete)),
                    ],
                  ),
                  subtitle: Text(client['email'] ?? ''),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/new-client');
        },
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
