import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_bucket_list/ViewModel/model_state_detail.dart';
import 'package:restaurant_bucket_list/models/api/restaurant_detail.dart';
import 'package:restaurant_bucket_list/screens/home_restaurant_list.dart';



class RestaurantDetailPage extends StatefulWidget {
  final String restaurantId;

  const RestaurantDetailPage({Key? key, required this.restaurantId}) : super(key: key);

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RestaurantDetailProvider>(context, listen: false)
          .fetchRestaurantDetail(widget.restaurantId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Restaurant Details", style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold,color:Colors.white),),
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
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
    return const Center(child: CircularProgressIndicator());
  } else if (provider.errorMessage != null) {
    return Center(child: Text(provider.errorMessage!));  // Display error message if present
  }
         return Stack(
         children:[
          Container(
             height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://restaurant-api.dicoding.dev/images/medium/${provider.restaurantDetail!.pictureId}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
           DraggableScrollableSheet(
                initialChildSize: 0.5, // starting at 60% of the screen height
                minChildSize: 0.5, // can shrink to 50% of the screen height
                maxChildSize: 1.0, // can expand to full screen
                builder: (BuildContext context, ScrollController scrollController) {
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 5, blurRadius: 7),
                      ],
                    ),
            child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Align(
               alignment: Alignment.center, // Memusatkan hanya ikon ini
               child: const Icon(
                Icons.arrow_upward,
                size: 24.0,
                color: Colors.white,
              ),
            ),
                const SizedBox(height: 12),
                      Text(provider.restaurantDetail!.name, style: GoogleFonts.montserrat( fontSize: 20, fontWeight: FontWeight.bold,color:Colors.white,)),
                      Text(provider.restaurantDetail!.city, style: GoogleFonts.openSans( fontSize: 18, fontWeight: FontWeight.bold,color:Color(0xFFFF5F00))),
                      if (provider.restaurantDetail!.address != null)
                        Text(provider.restaurantDetail!.address!, style: GoogleFonts.montserrat( fontSize: 16, fontWeight: FontWeight.bold,color:Colors.white)),
                      const SizedBox(height: 20),
                      Text("Description:", style: GoogleFonts.montserrat( fontSize: 16, fontWeight: FontWeight.bold,color:Color(0xFFFF5F00))),
                      Text(provider.restaurantDetail!.description, style: GoogleFonts.montserrat( fontSize: 14, fontWeight: FontWeight.bold,color:Colors.white,)),
                      const SizedBox(height: 20),
                      _buildCategoryChips("Categories:", provider.restaurantDetail!.categories),
                      _buildMenuSection("Foods:", provider.restaurantDetail!.menus?.foods),
                      _buildMenuSection("Drinks:", provider.restaurantDetail!.menus?.drinks),
                     ],
                     
                    ),
                  ),
                );
        },
        ),
            ],
          );
        },
      ),
    );
  }
  Widget _buildCategoryChips(String title, List<Category>? categories) {
    if (categories == null || categories.isEmpty) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.montserrat( fontSize: 16, fontWeight: FontWeight.bold,color:Colors.white,)),
        Wrap(
          spacing: 8.0,
          children: categories.map((category) => Chip(label: Text(category.name, style: GoogleFonts.montserrat( fontSize: 14, fontWeight: FontWeight.bold,color:Colors.black,)))).toList(),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildMenuSection(String title, List<Category>? items) {
    if (items == null || items.isEmpty) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.montserrat( fontSize: 16, fontWeight: FontWeight.bold,color:Colors.white,)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: items.map((item) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Chip(
                
                label: Text(item.name, style: GoogleFonts.montserrat( fontSize: 14, fontWeight: FontWeight.bold,color:Colors.black,))),
            )).toList(),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
