import 'package:dio/dio.dart';
import 'package:restaurant_bucket_list/models/api/restaurant_detail.dart';

class ApiServiceDetail {
  final Dio dio;

  ApiServiceDetail(this.dio);

  Future<RestaurantDetail> fetchRestaurantDetails(String id) async {
    try {
      // Properly inject the restaurant ID into the URL
      Response response = await dio.get('https://restaurant-api.dicoding.dev/detail/$id');
      if (response.statusCode == 200) {
        RestoDetail restoDetail = RestoDetail.fromJson(response.data);
        if (!restoDetail.error) {
          return restoDetail.restaurant;
        } else {
          throw Exception('API Error: ${restoDetail.message}');
        }
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } on DioError catch (dioError) {
      // Handle Dio-specific errors here
      throw Exception('Dio error: $dioError');
    } catch (e) {
      // Handle other errors
      throw Exception('General error: $e');
    }
  }
}