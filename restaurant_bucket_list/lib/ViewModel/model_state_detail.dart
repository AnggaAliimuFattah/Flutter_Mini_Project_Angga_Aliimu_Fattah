import 'package:flutter/material.dart';
import 'package:restaurant_bucket_list/models/api/restaurant_detail.dart';
import 'package:restaurant_bucket_list/services/api_service_detail.dart';


class RestaurantDetailProvider with ChangeNotifier {
  final ApiServiceDetail apiServiceDetail;
  RestaurantDetail? _restaurantDetail;
  bool _isLoading = false;
  String? _errorMessage;

  RestaurantDetailProvider({required this.apiServiceDetail});

  RestaurantDetail? get restaurantDetail => _restaurantDetail;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchRestaurantDetail(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _restaurantDetail = await apiServiceDetail.fetchRestaurantDetails(id);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}