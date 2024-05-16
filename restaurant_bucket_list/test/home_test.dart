import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_bucket_list/ViewModel/Model_state.dart';
import 'package:restaurant_bucket_list/ViewModel/navigation.dart';
import 'package:restaurant_bucket_list/models/api/restaurant_list.dart';
import 'package:restaurant_bucket_list/screens/home_restaurant_list.dart';
import 'package:restaurant_bucket_list/services/api_service_list.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_bucket_list/models/api/restaurant_list.dart' as restaurantModel; // Berikan alias pada impor

class MockApiServiceList extends Mock implements ApiServiceList {}

void main() {
  testWidgets('Testing RestaurantListHome UI Elements', (WidgetTester tester) async {
    // Create mock instance
    MockApiServiceList mockApiServiceList = MockApiServiceList();

    
    // Initialize your providers with mocks
    RestaurantProvider restaurantProvider = RestaurantProvider(apiService: mockApiServiceList);
    NavigationProvider navigationProvider = NavigationProvider();

    // Wrap your RestaurantListHome in the necessary providers
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<RestaurantProvider>(create: (_) => restaurantProvider),
          ChangeNotifierProvider<NavigationProvider>(create: (_) => navigationProvider),
        ],
        child: MaterialApp(home: const RestaurantListHome()),
      ),
    );

    // Pump the widget
    await tester.pump();

    // Perform your widget tests
    expect(find.byKey(const Key('Judul List Home')), findsOneWidget);

    expect(find.byKey(const Key('HomeNavButton')), findsOneWidget);
    expect(find.byKey(const Key('SearchNavButton')), findsOneWidget);
    expect(find.byKey(const Key('ReviewsNavButton')), findsOneWidget);
    expect(find.byKey(const Key('ChatBotNavButton')), findsOneWidget);

    // Pump and settle to complete all animations and pending tasks
    await tester.pumpAndSettle();
  });
}
