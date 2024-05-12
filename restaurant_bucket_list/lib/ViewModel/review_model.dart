import 'package:flutter/material.dart';
import 'package:restaurant_bucket_list/models/api/review.dart';
import 'package:restaurant_bucket_list/services/review_service_delete.dart';
import 'package:restaurant_bucket_list/services/review_service_get.dart';
import 'package:restaurant_bucket_list/services/review_service_post.dart';
import 'package:restaurant_bucket_list/services/review_service_put.dart';

class ReviewsProvider with ChangeNotifier {
  List<Review> _reviews = [];
   bool _isLoading = false;
  String? _errorMessage;
  final ApiServicePost _reviewServicePost;
  final ApiServiceUpdate _reviewServiceUpdate;
  final ApiServiceDelete _reviewServiceDelete;
  final ApiServiceGet _apiServiceGet;

  ReviewsProvider(this._reviewServicePost, this._reviewServiceUpdate, this._reviewServiceDelete,this._apiServiceGet);

  List<Review> get reviews => _reviews;


  String? get errorMessage => _errorMessage;
   bool get isLoading => _isLoading;

  void addReview(Review review) async {
  try {
    final newReview = await _reviewServicePost.addReview(review);
    if (newReview != null) {
      _reviews.add(newReview);
      notifyListeners();
    }
  } catch (e) {
    print('Error adding review: $e');
  }
  }

  void updateReview(String id, Review newReview) async {
    final updatedReview = await _reviewServiceUpdate.updateReview(id, newReview);
    if (updatedReview != null) {
      int index = _reviews.indexWhere((r) => r.id == id);
      if (index != -1) {
        _reviews[index] = updatedReview;
        notifyListeners();
      }
    }
  }

  void removeReview(String id) async {
    bool success = await _reviewServiceDelete.deleteReview(id);
    if (success) {
      _reviews.removeWhere((r) => r.id == id);
      notifyListeners();
    }
  }
  Future<void> fetchReviews() async {
    _isLoading = true;
    notifyListeners();
    try {
      _reviews = await _apiServiceGet.fetchReviews();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to load reviews: $e';
    }
    _isLoading = false;
    notifyListeners();
  }
}