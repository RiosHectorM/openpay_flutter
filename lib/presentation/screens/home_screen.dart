import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: const Text('Nuevo Usuario'),
            subtitle: const Text('Agregar Nuevo Usuario al Sistema'),
            trailing: const Icon(Icons.person_add_alt_sharp),
            onTap: () => context.push('/addUser'),
          ),
          ListTile(
            title: const Text('Buscar Sucursales cercanas'),
            subtitle: const Text('Listado de Sucursales cercanas a tu posicion'),
            trailing: const Icon(Icons.map_rounded),
            onTap: () => context.push('/locationsNearby'),
          )
        ],
      ),
    );
  }
}

