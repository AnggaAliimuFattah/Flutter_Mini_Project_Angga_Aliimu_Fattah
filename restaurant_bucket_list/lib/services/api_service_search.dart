
import 'package:restaurant_bucket_list/models/api/restaurant_search.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
 
 class SearchApiService {
  Future<SearchModel> fetchRestaurants(String query) async {
    final response = await http.get(Uri.parse('https://restaurant-api.dicoding.dev/search?q=$query'));

    if (response.statusCode == 200) {
      return SearchModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurants');
    }
  }
 }