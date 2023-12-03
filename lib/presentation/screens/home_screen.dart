import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Menu Principal Clientes / Sucursales
      body: ListView(
        children: [
          ListTile(
            title: const Text('Clientes'),
            subtitle: const Text('Agregar, Editar o Eliminar Clientes'),
            trailing: const Icon(Icons.person_add_alt_sharp),
            onTap: () => context.push('/list-clients'),
          ),
          ListTile(
            title: const Text('Sucursales'),
            subtitle: const Text('Listado de Sucursales cercanas por ciudad'),
            trailing: const Icon(Icons.map_rounded),
            onTap: () => context.push('/list-markets'),
          )
        ],
      ),
    );
  }
}

