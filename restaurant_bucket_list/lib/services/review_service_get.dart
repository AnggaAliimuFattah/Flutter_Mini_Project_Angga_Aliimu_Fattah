import 'package:dio/dio.dart';
import 'package:restaurant_bucket_list/models/api/review.dart';

class ApiServiceGet {
  final Dio client;
  final String baseUrl = "https://6638f3b24253a866a24fca22.mockapi.io/review";

  ApiServiceGet(this.client);

  Future<List<Review>> fetchReviews() async {
    try {
      final response = await client.get(baseUrl);
      if (response.statusCode == 200) {
        List<Review> reviews = (response.data as List).map((data) {
          return Review.fromJson(data);
        }).toList();
        return reviews;
      } else {
        throw Exception("Failed to load reviews");
      }
    } catch (e) {
      throw Exception('Failed to load reviews: $e');
    }
  }
}