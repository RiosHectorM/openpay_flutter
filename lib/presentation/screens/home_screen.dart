import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Principal'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          buildCard(
            'Clientes',
            'Agregar, Editar o Eliminar Clientes',
            Icons.people_alt_outlined,
            () => context.push('/list-clients'),
          ),
          const SizedBox(height: 16.0),
          buildCard(
            'Sucursales',
            'Listado de Sucursales cercanas por ciudad',
            Icons.account_balance_outlined,
            () => context.push('/list-markets'),
          ),
        ],
      ),
    );
  }

  Widget buildCard(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 5.0,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 40.0),
              const SizedBox(height: 8.0),
              Text(
                title,
                style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(subtitle),
            ],
          ),
        ),
      ),
    );
  }
}
