import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:openpay_flutter/repositories/market_list.dart';
import 'package:openpay_flutter/datasources/market_list_api.dart';
import 'package:openpay_flutter/datasources/cordinates.dart';

class ListMarketScreen extends StatefulWidget {
  final MarketRepository marketRepository =
      MarketRepositoryImpl(MarketApi(Dio()));

  ListMarketScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ListMarketScreenState createState() => _ListMarketScreenState();
}

class _ListMarketScreenState extends State<ListMarketScreen> {
  List<Map<String, dynamic>> markets = [];
  City? selectedCity;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sucursales por Ciudad'),
      ),
      body: selectedCity == null
      ? const Center(
          child: Text('Seleccione una ciudad ver las Sucursales'),
        )
      : isLoading
      ? const Center(
          child: CircularProgressIndicator(),
        )
      : markets.isEmpty
          ? const Center(
              child: Text('No hay sucursales disponibles.'),
            )
          : ListView.builder(
              itemCount: markets.length * 2 - 1,
              itemBuilder: (context, index) {
                if (index.isOdd) {
                  // Si es impar, devuelve un Divider
                  return const Divider();
                } else {
                  // Si es par, devuelve un ListTile
                  final marketIndex = index ~/ 2;
                  final market = markets[marketIndex];
                  return ListTile(
                    title: Text(
                      market['name'] ?? '',
                      textAlign: TextAlign.left,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          market['address']['line1'] ?? '',
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                            (market['address']['line2'] ?? '') +
                                ' ' +
                                (market['address']['state'] ?? ''),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  );
                }
              },
            ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 2),
          const Text(
            'Seleccione ciudad:',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,              
            ),
          ),
          const Spacer(flex: 1),
          Container(
            margin: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Colors.blue[100],  // Cambia esto al color de fondo deseado
              borderRadius: BorderRadius.circular(10.0),  // Ajusta el radio del borde según tus preferencias
              border: Border.all(color: Colors.blue),  // Ajusta el color del borde según tus preferencias
            ),
            child: DropdownButton<String>(
              value: selectedCity?.name,
              onChanged: (String? newValue) async {
                setState(() {
                  selectedCity = getMexicanCities()
                      .firstWhere((city) => city.name == newValue);
                  isLoading = true;
                });
            
                if (selectedCity != null) {
                  try {
                    final marketList =
                        await widget.marketRepository.getListOfMarkets(
                      latitude: selectedCity?.latitude,
                      longitude: selectedCity?.longitude,
                    );
            
                    setState(() {
                      markets = marketList;
                      isLoading = false;
                    });
                  } catch (error) {
                    setState(() {
                      isLoading = false;
                    });
                    throw Exception(
                        'Error al obtener la lista de Sucursales: $error');
                  }
                }
              },
              items:
                  getMexicanCities().map<DropdownMenuItem<String>>((City value) {
                return DropdownMenuItem<String>(
                  value: value.name,
                  child: Text(value.name),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
