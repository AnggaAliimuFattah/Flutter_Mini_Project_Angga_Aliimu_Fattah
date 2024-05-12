import 'package:dio/dio.dart';
import 'package:restaurant_bucket_list/models/api/restaurant_list.dart'; // Ganti dengan lokasi file model Anda
class ApiServiceList {
  Dio client;
  ApiServiceList(this.client);

  // URL dasar untuk API
  final String baseUrl = "https://restaurant-api.dicoding.dev";

  // Fetch list of restaurants
  Future<List<Restaurant>> fetchRestaurants() async {
    try {
      final response = await client.get('$baseUrl/list');
      if (response.statusCode == 200) {
        var data = response.data; // Dio sudah otomatis decode JSON
        List<Restaurant> restaurants = (data['restaurants'] as List)
            .map((restaurantJson) => Restaurant.fromJson(restaurantJson))
            .toList();
        return restaurants;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}