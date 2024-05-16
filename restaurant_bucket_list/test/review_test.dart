import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_bucket_list/ViewModel/navigation.dart';
import 'package:restaurant_bucket_list/screens/reviewscreen.dart';
import 'package:restaurant_bucket_list/ViewModel/review_model.dart';
import 'package:restaurant_bucket_list/services/review_service_delete.dart';
import 'package:restaurant_bucket_list/services/review_service_get.dart';
import 'package:restaurant_bucket_list/services/review_service_post.dart';
import 'package:restaurant_bucket_list/services/review_service_put.dart';
import 'package:mockito/mockito.dart';


class MockApiServicePost extends Mock implements ApiServicePost {}
class MockApiServiceUpdate extends Mock implements ApiServiceUpdate {}
class MockApiServiceDelete extends Mock implements ApiServiceDelete {}
class MockApiServiceGet extends Mock implements ApiServiceGet {}

void main() {
  testWidgets('Testing ReviewScreen UI Elements', (WidgetTester tester) async {
    // Create mock instances
    MockApiServicePost mockApiServicePost = MockApiServicePost();
    MockApiServiceUpdate mockApiServiceUpdate = MockApiServiceUpdate();
    MockApiServiceDelete mockApiServiceDelete = MockApiServiceDelete();
    MockApiServiceGet mockApiServiceGet = MockApiServiceGet();

    // Initialize your providers with mocks
    ReviewsProvider reviewsProvider = ReviewsProvider(
        mockApiServicePost,
        mockApiServiceUpdate,
        mockApiServiceDelete,
        mockApiServiceGet);

    NavigationProvider navigationProvider = NavigationProvider();

    // Wrap your ReviewScreen in the necessary providers
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ReviewsProvider>(create: (_) => reviewsProvider),
          ChangeNotifierProvider<NavigationProvider>(create: (_) => navigationProvider),
        ],
        child: MaterialApp(home: const ReviewScreen()),
      ),
    );

    // Perform your widget tests
    expect(find.byKey(const Key("Name")), findsOneWidget);
    expect(find.byKey(const Key("Review")), findsOneWidget);
    expect(find.byKey(const Key("Date")), findsOneWidget);

    expect(find.byKey(const Key('HomeNavButton')), findsOneWidget);
    expect(find.byKey(const Key('SearchNavButton')), findsOneWidget);
    expect(find.byKey(const Key('ReviewsNavButton')), findsOneWidget);
    expect(find.byKey(const Key('ChatBotNavButton')), findsOneWidget);

    // Pump and settle to complete all animations and pending tasks
    await tester.pumpAndSettle();
  });
}