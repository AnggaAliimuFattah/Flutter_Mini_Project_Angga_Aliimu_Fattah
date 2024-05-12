import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_bucket_list/screens/Login_page.dart';


void main() {
  testWidgets('Testing 1 text, 2 field dan 1 button', (WidgetTester widgetTester) async {
    // Build our app and trigger a frame.
    await widgetTester.pumpWidget( MaterialApp(home: const LoginPage()));

    expect(find.byKey(const Key("My Login Page")), findsOneWidget);
    expect(find.byKey(const Key("Username Text Field")), findsOneWidget);
    expect(find.byKey(const Key("Password Text Field")), findsOneWidget);
    expect(find.byKey(const Key("Submit Login Button")), findsOneWidget);
  });
}