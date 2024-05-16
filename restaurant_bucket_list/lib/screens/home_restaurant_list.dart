import 'package:flutter/material.dart';
import 'package:restaurant_bucket_list/screens/Login_page.dart';
import 'package:restaurant_bucket_list/screens/restaurant_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restaurant_bucket_list/ViewModel/Model_state.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_bucket_list/ViewModel/navigation.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
class RestaurantListHome extends StatefulWidget {
  
  const RestaurantListHome({super.key});

  @override
  State<RestaurantListHome> createState() => _RestaurantListHomeState();
}

class _RestaurantListHomeState extends State<RestaurantListHome> {
   //int _selectedIndex = 0;
  late SharedPreferences logindata;
  String username = '';

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username') ?? '';
    });
  }
 

  List<Widget> buildRatingStars(double rating, double size) {
    List<Widget> stars = [];
    int numberOfFullStars = rating.floor();
    for (int i = 0; i < numberOfFullStars; i++) {
      stars.add(Icon(Icons.star, color: Colors.amber, size: size));
    }
    if (rating - numberOfFullStars >= 0.5) {
      stars.add(Icon(Icons.star_half, color: Colors.amber, size: size));
    }
    return stars;
  }

void _logout() {
    logindata.setBool('login', true);
    logindata.remove('username');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF16181F),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:  Text('Restaurant B.L', style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold,color:Colors.white),
        key: Key('Judul List Home'),
        ),
        centerTitle: false,
        backgroundColor: Color(0xFF262A36),
         shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),  // Define the radius of the curve here
    ),
  ),
        actions: [
          IconButton(
            onPressed: () {
              logindata.setBool('login', true);
              logindata.remove('username');
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            icon: const Icon(Icons.logout, color: Colors.white,),
          ),
        ],
      ),
      body:  Consumer<RestaurantProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          return Container(
             color: Color(0xFF16181F), 
            child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.02), // Responsive padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Restaurants", 
                    style: GoogleFonts.montserrat(fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold, color: Color.fromARGB(232, 241, 240, 240))), // Responsive font size
                    Text("Recommendations based on your preferences", style: GoogleFonts.openSans(fontSize: screenWidth * 0.04, color: Color.fromARGB(255, 176, 176, 176))), // Responsive font size
                  ],
                ),
              ),
              Expanded(
            child: Container(  
            child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
           maxCrossAxisExtent: 200, // jumlah kolom
            childAspectRatio: 3 / 4, // proporsi antara lebar dan tinggi tiap item
            crossAxisSpacing: 10, // jarak antar item secara horizontal
            mainAxisSpacing: 10, // jarak antar item secara vertikal
          ),
          itemCount: provider.restaurants.length, // jumlah item yang ingin ditampilkan
          itemBuilder: (context, index) {
            var restaurant = provider.restaurants[index];
            print('Restaurant ID: ${restaurant.id}');
            return InkWell(
          onTap: () {
            // Aksi yang terjadi ketika Card di-tap
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RestaurantDetailPage(restaurantId: restaurant.id),
              ),
            );
          },
            child:  Card(
              clipBehavior: Clip.antiAliasWithSaveLayer, // untuk melingkari gambar
               color: Color(0xFF262A36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.network(
                      "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${restaurant.name}",
                      style:  GoogleFonts.montserrat(
                        fontSize: screenWidth * 0.035,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                   Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 2.0),
                  child: Text(
                    restaurant.city,
                    style: GoogleFonts.montserrat(
                      fontSize: screenWidth * 0.035,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,  // Set as normal to differentiate from the name
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                    child: Row(
                      children: [
                        Text("${restaurant.rating.toStringAsFixed(1)} ",
                          style: GoogleFonts.montserrat(
                        fontSize: screenWidth * 0.035,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: buildRatingStars(restaurant.rating, screenWidth * 0.035),
                  ),
                ],
              ),
              
            ),
          ],
        ),
            ),
            );
    },
  ),
),
            ),
            ],
          ),
          );
        },
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
            GButton(
            key: Key('HomeNavButton'),  
            icon: Icons.home,
            text: 'Home',),
            GButton(
            key: Key('SearchNavButton'),
            icon: Icons.search,
            text: 'Search',),
            GButton(
            key: Key('ReviewsNavButton'),
            icon: Icons.reviews,
            text: 'Reviews',),
            GButton(
            key: Key('ChatBotNavButton'),
            icon: Icons.chat,
            text: 'Chat Bot',),
          ],
        );
  },
  ),
      );
  }
}
