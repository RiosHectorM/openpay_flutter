import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:openpay_flutter/presentation/screens/screens.dart';
import 'package:openpay_flutter/repositories/openpay_crud.dart';
import 'package:openpay_flutter/datasources/openpay_api.dart';
import 'package:go_router/go_router.dart';

class ListClientsScreen extends StatefulWidget {
  final UserRepository userRepository = UserRepositoryImpl(OpenPayApi(Dio()));

  ListClientsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
      throw Exception('Error al obtener la lista de clientes: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Clientes'),
      ),
      body: clients.isEmpty
          ? FutureBuilder(
              future: Future.delayed(const Duration(seconds: 2)), // Espera 2 segundos y hace el If
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Mientras espera, muestra el indicador de carga
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  // Despues de esperar, muestra el mensaje "Sin clientes"
                  return const Center(
                    child: Text('No hay Clientes'),
                  );
                }
              },
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
                        onPressed: () async {
                          await Navigator.of(context)
                              .push(
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(
                                  isEditing: true, client: clients[index]),
                            ),
                          )
                              .then((_) async {
                            // Actualiza la lista despues de la edicion
                            await fetchListOfClients();
                          });
                        },
                        child: const Icon(Icons.edit),
                      ),
                      // Espacio entre los botones
                      const SizedBox(width: 4), 
                      //Botones de Editar y Eliminar
                      ElevatedButton(
                          onPressed: () async {
                            try {
                              await widget.userRepository
                                  .deleteUser(client['id']);
                              // Mostrar SnackBar de exito
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Cliente Eliminado exitosamente'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              // Actualiza la lista despues de la eliminacion
                              await fetchListOfClients();
                            } catch (error) {
                              // Mostrar SnackBar de error
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Error al Eliminar el Cliente: $error'),
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
        onPressed: () async {
          await context.push('/new-client').then((_) async {
            await fetchListOfClients();
          });
        },
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
