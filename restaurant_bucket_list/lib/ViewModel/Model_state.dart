import 'package:flutter/material.dart';
import 'package:restaurant_bucket_list/models/api/restaurant_list.dart';
import 'package:restaurant_bucket_list/services/api_service_list.dart';
import 'package:dio/dio.dart';

class RestaurantProvider with ChangeNotifier {
  Dio _dio = Dio();
  List<Restaurant> _restaurants = [];
  bool _isLoading = false;

  List<Restaurant> get restaurants => _restaurants;
  bool get isLoading => _isLoading;

  late ApiServiceList _apiService;

  RestaurantProvider({required ApiServiceList apiService}) {
    _apiService = ApiServiceList(_dio);
    fetchRestaurants();
  }

  Future<void> fetchRestaurants() async {
    _isLoading = true;
    notifyListeners();

    try {
      _restaurants = await _apiService.fetchRestaurants();
    } catch (e) {
      print("Error occurred while fetching data: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  
}