import 'package:dio/dio.dart';
import 'package:restaurant_bucket_list/models/api/review.dart';


class ApiServiceUpdate {
  Dio client;
  ApiServiceUpdate(this.client);

  // Base URL for the API endpoint
  final String baseUrl = "https://6638f3b24253a866a24fca22.mockapi.io/review/";

  // Update an existing restaurant review
 Future<Review> updateReview(String reviewId, Review review) async {
    try {
      final String url = '$baseUrl$reviewId';  // Append review ID to the URL
      final response = await client.put(
        url,
        data: review.toJson(), // Serialize the updated review object to JSON
      );
      if (response.statusCode == 200) {
        return Review.fromJson(response.data); // Deserialize the JSON response to a Review object
      } else {
        throw Exception('Failed to update review');
      }
    } catch (e) {
      throw Exception('Failed to update review: $e');
    }
  }
}