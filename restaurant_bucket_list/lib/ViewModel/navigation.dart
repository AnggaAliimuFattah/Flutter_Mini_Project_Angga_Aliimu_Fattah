import 'package:flutter/material.dart';
import 'package:restaurant_bucket_list/screens/home_restaurant_list.dart';
import 'package:restaurant_bucket_list/screens/restaurant_search.dart';
import 'package:restaurant_bucket_list/screens/reviewscreen.dart';
import 'package:restaurant_bucket_list/screens/chatAI_screen.dart';
// import 'package:restaurant_bucket_list/screens/your_favorites_page.dart';
// import 'package:restaurant_bucket_list/screens/your_reviews_page.dart';


class NavigationProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index, BuildContext context) {
    _selectedIndex = index;
    notifyListeners();
   navigateToScreen(index, context);
  }

void navigateToScreen(int index, BuildContext context) {
  switch (index) {
    case 0:
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => RestaurantListHome()));
      break;
    case 1:
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => RestaurantSearchPage()));
      break;
     case 2:
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ReviewScreen()));
      break;
      case 3:
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ChatAI()));
      break;
  }
}
}