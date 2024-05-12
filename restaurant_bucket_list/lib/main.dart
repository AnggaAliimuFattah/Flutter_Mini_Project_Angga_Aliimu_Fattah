import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_bucket_list/ViewModel/Model_state.dart';
import 'package:restaurant_bucket_list/ViewModel/model_state_detail.dart';
import 'package:restaurant_bucket_list/ViewModel/model_state_search.dart';
import 'package:restaurant_bucket_list/ViewModel/navigation.dart';
import 'package:restaurant_bucket_list/ViewModel/review_model.dart';
import 'package:restaurant_bucket_list/screens/splash_screen.dart';
import 'package:restaurant_bucket_list/services/api_service_detail.dart';
import 'package:restaurant_bucket_list/services/api_service_list.dart';
import 'package:restaurant_bucket_list/services/api_service_search.dart';
import 'package:restaurant_bucket_list/services/review_service_get.dart';
import 'package:restaurant_bucket_list/services/review_service_post.dart';
import 'package:restaurant_bucket_list/services/review_service_put.dart';
import 'package:restaurant_bucket_list/services/review_service_delete.dart';

void main() {
  Dio dioClient = Dio(); // Creates a single instance of Dio to be used across the app
  runApp(MyApp(dioClient: dioClient));
}

class MyApp extends StatelessWidget {
  final Dio dioClient;

  MyApp({required this.dioClient});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RestaurantProvider(apiService: ApiServiceList(dioClient)),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantDetailProvider(apiServiceDetail: ApiServiceDetail(dioClient)),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(SearchApiService()),
        ),
        ChangeNotifierProvider(
             create: (context) => ReviewsProvider(
              ApiServicePost(dioClient),  // Assuming this is your POST service
              ApiServiceUpdate(dioClient), // Assuming this is your PUT service
              ApiServiceDelete(dioClient), // Assuming this is your DELETE service
              ApiServiceGet(dioClient),// Assuming this is your GET service
  ),
),
 ChangeNotifierProvider(
          create: (context) =>  NavigationProvider()
        ),
        // Other providers can be added here if necessary
      ],
      child: MaterialApp(
        title: 'Restaurant Bucket List',
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}