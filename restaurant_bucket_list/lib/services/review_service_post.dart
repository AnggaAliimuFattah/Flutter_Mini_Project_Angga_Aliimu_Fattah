import 'package:dio/dio.dart';
import 'package:restaurant_bucket_list/models/api/review.dart';


class ApiServicePost {
  Dio client;
  ApiServicePost(this.client);

  final String baseUrl = "https://6638f3b24253a866a24fca22.mockapi.io/review";

  // Add a new restaurant review
  Future<Review> addReview(Review review) async {
    try {
      final response = await client.post(
        baseUrl,
        data: review.toJson(), // Assuming you have a method `toJson` in your Review model
      );
      if (response.statusCode == 200) {
        return Review.fromJson(response.data); // Assuming you have a fromJson factory method
      } else {
        throw Exception('Failed to add review');
      }
    } catch (e) {
      throw Exception('Failed to add review: $e');
    }
  }
}