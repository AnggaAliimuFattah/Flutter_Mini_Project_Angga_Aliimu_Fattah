import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_bucket_list/ViewModel/navigation.dart';
import 'package:restaurant_bucket_list/screens/chatAI_screen.dart';



void main() {
  testWidgets('Testing 1 text, 1 field dan 5 button', (WidgetTester widgetTester) async {
     NavigationProvider navigationProvider = NavigationProvider();
    await widgetTester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<NavigationProvider>(create: (_) => navigationProvider),
        ],
        child: MaterialApp(home: const ChatAI()),
      ),
    );

     // Perform your widget tests
    expect(find.byKey(const Key("judul Page AI")), findsOneWidget);

    expect(find.byKey(const Key("Field Pesan")), findsOneWidget);
   

    expect(find.byKey(const Key("Submit Button")), findsOneWidget);
    expect(find.byKey(const Key('HomeNavButton')), findsOneWidget);
    expect(find.byKey(const Key('SearchNavButton')), findsOneWidget);
    expect(find.byKey(const Key('ReviewsNavButton')), findsOneWidget);
    expect(find.byKey(const Key('ChatBotNavButton')), findsOneWidget);
  });
}