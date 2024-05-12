import  'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_bucket_list/ViewModel/model_state_search.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_bucket_list/ViewModel/navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_bucket_list/screens/home_restaurant_list.dart';
import 'package:restaurant_bucket_list/screens/restaurant_detail.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class RestaurantSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF16181F),
      appBar: AppBar(
         automaticallyImplyLeading: false,
        title: Text("Restaurant Search", style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold,color:Colors.white),),
         centerTitle: false,
        backgroundColor: Color(0xFF5A5A5A),
                actions: [ 
          IconButton(
          icon: Icon(Icons.home, color: Colors.black),  // Icon color is black
          onPressed: () {
          Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) =>  RestaurantListHome()),
              );
          },
         ),
        ],
      ),
      body: Column(
        
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueGrey[700]!, Colors.blueGrey[300]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Find Your Favorite Restaurant",
                style: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 20),
      Expanded(  
        child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF16181F),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(2),
                ),
              ),
        child:  Consumer<SearchProvider>(  // Pastikan menggunakan tipe SearchProvider
        builder: (context, searchProvider, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                  child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
                child: TextField(
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      searchProvider.fetchSearchResults(value);
                    }
                  },
                  decoration: InputDecoration(
                  labelText: 'Search',
                   labelStyle: GoogleFonts.montserrat(
                  color: Color.fromARGB(255, 108, 98, 98), // Set the label text color to white
                  fontSize: screenWidth * 0.04,
                  fontWeight:FontWeight.bold// Consistent font size with input text
              ),
                  prefixIcon: Icon(Icons.search),
                   contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                ),
              ),
              ),
              Expanded(
                child: searchProvider.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : searchProvider.searchModel == null
                        ? Text('No results found or error: ${searchProvider.errorMessage}')
                        : ListView.builder(
                            itemCount: searchProvider.searchModel!.restaurants.length,
                            itemBuilder: (context, index) {
                              var restaurant = searchProvider.searchModel!.restaurants[index];
                              return ListTile(
                                leading: Image.network(
                                "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                                width: screenWidth * 0.12,
                                 height: screenWidth * 0.12,
                                fit: BoxFit.cover,
                      ),
                                title: Text(
                                  restaurant.name,
                                  style: GoogleFonts.montserrat(
                                  fontSize: screenWidth * 0.04,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  ),                             
                                    ),
                                subtitle: Text("City : ${restaurant.city} - Rating : ${restaurant.rating}",
                                style: GoogleFonts.openSans(
                                fontSize: screenWidth * 0.035,
                                color: Color.fromARGB(255, 250, 249, 249),
                                fontWeight: FontWeight.bold,
                                ),
                                ),
                                onTap: () {
                                Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RestaurantDetailPage(restaurantId: restaurant.id),
                              ),
                            );
                                }
                              );
                            },
                          ),
              ),
            ],
          );
        },
      ),
    )
      ),
      ],
    ),
     bottomNavigationBar: Consumer<NavigationProvider>(
        builder: (context, navigationProvider, child) {
        return GNav(
          selectedIndex: navigationProvider.selectedIndex,
         backgroundColor: Color(0xFF262A36),
          gap: 8,
          onTabChange: (index) {
          navigationProvider.setSelectedIndex(index, context); // Menggunakan fungsi navigasi yang diimpor
        },
          padding: EdgeInsets.all(17),
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade800,
          tabs: const [
            GButton(icon: Icons.home,
            text: 'Home',),
            GButton(icon: Icons.search,
            text: 'Search',),
            GButton(icon: Icons.reviews,
            text: 'Reviews',),
            GButton(icon: Icons.chat,
            text: 'Chat Bot',),
          ],
        );
  },
  ),
    );
  }
}