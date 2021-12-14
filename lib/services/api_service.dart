import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_task/model/car.dart';

class ApiService {
  Future<List<Car>> fetchCars() async {
    const String exceptionMsg = 'Failed to load Cars';
    const String jsonCars = 'cars';
    final response = await http.get(Uri.parse(
        'http://filehost.feelsoftware.com/jsonplaceholder/cars-api.php'));

    List<Car> cars = [];
    if (response.statusCode == 200) {
      var carsJson = json.decode(response.body)[jsonCars];
      for (var carJson in carsJson) {
        cars.add(Car.fromJson(carJson));
      }

      return cars;
    } else {
      throw Exception(exceptionMsg);
    }
  }
}
