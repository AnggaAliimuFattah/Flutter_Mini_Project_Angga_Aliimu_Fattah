import 'package:flutter/material.dart'; 
import 'package:restaurant_bucket_list/models/api/restaurant_search.dart';
import 'package:restaurant_bucket_list/services/api_service_search.dart';



class SearchProvider with ChangeNotifier {
  SearchApiService _apiService;
  SearchModel? _searchModel;
  bool _isLoading = false;
  String _errorMessage = '';

  SearchProvider(this._apiService);

  SearchModel? get searchModel => _searchModel;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  void fetchSearchResults(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      _searchModel = await _apiService.fetchRestaurants(query);
      _errorMessage = '';
    } catch (e) {
      _errorMessage = e.toString();
      _searchModel = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  void searchRestaurants(String value) {}
}