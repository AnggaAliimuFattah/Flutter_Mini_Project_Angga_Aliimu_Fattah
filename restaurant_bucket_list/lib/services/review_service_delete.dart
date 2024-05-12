import 'package:dio/dio.dart';

class ApiServiceDelete {
  Dio client;
  ApiServiceDelete(this.client);

  // Base URL for the API endpoint
  final String baseUrl = "https://6638f3b24253a866a24fca22.mockapi.io/review/";

  // Delete an existing restaurant review
   Future<bool> deleteReview(String reviewId) async {
    try {
      final String url = '$baseUrl$reviewId';  // Append review ID to the URL
      final response = await client.delete(url);

      if (response.statusCode == 200) {
        return true; // Successfully deleted the review
      } else {
        return false; // Failed to delete the review
      }
    } catch (e) {
      throw Exception('Failed to delete review: $e');
    }
  }
}