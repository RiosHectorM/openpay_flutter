
class City {
  final String name;
  final double latitude;
  final double longitude;

  City({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}

List<City> getMexicanCities() {
  return [
    City(name: 'Ciudad de México', latitude: 19.4326, longitude: -99.1332),
    City(name: 'Guadalajara', latitude: 20.6597, longitude: -103.3496),
    City(name: 'Monterrey', latitude: 25.438, longitude: -100.9737),
    City(name: 'Puebla', latitude: 19.0402, longitude: -98.2062),
    City(name: 'Querétaro', latitude: 20.5881, longitude: -100.3899),
    City(name: 'Cancún', latitude: 21.1619, longitude: -86.8515),
    City(name: 'Mérida', latitude: 20.9670, longitude: -89.6243),
    City(name: 'Tijuana', latitude: 32.5149, longitude: -117.0382),
    City(name: 'Veracruz', latitude: 19.1738, longitude: -96.1342),
    City(name: 'Toluca', latitude: 19.2826, longitude: -99.6557),
  ];
}

