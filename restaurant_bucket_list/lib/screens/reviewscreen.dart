import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_bucket_list/ViewModel/navigation.dart';
import 'package:restaurant_bucket_list/ViewModel/review_model.dart';
import 'package:restaurant_bucket_list/models/api/review.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key}) : super(key: key); 

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
  
}


class _ReviewScreenState extends State<ReviewScreen> {
  @override
void initState() {
  super.initState();
  // Fetch reviews when the screen is initialized
  Future.microtask(
    () => Provider.of<ReviewsProvider>(context, listen: false).fetchReviews()
  );
}
  
  int _selectedIndex = 0;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  @override 
  Widget build(BuildContext context) {
     double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
       backgroundColor: Color(0xFF16181F),
       appBar: AppBar(
        automaticallyImplyLeading: false,
        title:  Text('Review Restaurant', style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold,color:Colors.white),),
        centerTitle: false,
        backgroundColor: Color(0xFF262A36),
         shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),  // Define the radius of the curve here
    ),
  ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: _buildForm(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('List of Reviews', style:  GoogleFonts.montserrat(fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold, color: Color.fromARGB(232, 241, 240, 240))),
            ),
          ),
          Expanded(child: _buildReviewList()),
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

  Widget _buildForm() {
    double screenWidth = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, 
        children: <Widget>[
          Padding(
            padding:  const EdgeInsets.all(8.0),
          child : TextFormField(
            cursorColor: Colors.white,
            controller: _nameController,
             style:   GoogleFonts.montserrat(fontSize: screenWidth * 0.04,color: Colors.white,fontWeight: FontWeight.bold,),
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: GoogleFonts.montserrat(
              color: Colors.white, // Set the label text color to white
              fontSize: screenWidth * 0.04, // Consistent font size with input text
      ),
               contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0), // Rounded corners
          ),
        ),
            validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
          ),
          ),
          Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        cursorColor: Colors.white,
        controller: _reviewController,
         style:   GoogleFonts.montserrat(fontSize: screenWidth * 0.04,color: Colors.white,fontWeight: FontWeight.bold,),
        decoration: InputDecoration(
          labelText: 'Review',
          labelStyle: GoogleFonts.montserrat(
          color: Colors.white, // Set the label text color to white
          fontSize: screenWidth * 0.04, // Consistent font size with input text
      ),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0), // Adjust field size
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0), // Rounded corners
          ),
        ),
        validator: (value) => value!.isEmpty ? 'Please enter a review' : null,
      ),
    ),
          Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        cursorColor: Colors.white,
        controller: _dateController,
        style:   GoogleFonts.montserrat(fontSize: screenWidth * 0.04,color: Colors.white,fontWeight: FontWeight.bold,),
        decoration: InputDecoration(
          labelText: 'Date',
          labelStyle: GoogleFonts.montserrat(
          color: Colors.white, // Set the label text color to white
          fontSize: screenWidth * 0.04, // Consistent font size with input text
      ),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0), // Adjust field size
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0), // Rounded corners
          ),
        ),
        validator: (value) => value!.isEmpty ? 'Please enter a date' : null,
      ),
    ),
    Padding(
      padding:  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0), 
          child : ElevatedButton(
            onPressed: _handleSubmit,
            child: Text('Submit Review', style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold,  color: Color.fromARGB(255, 248, 100, 248),),),
             style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 82, 78, 63)),    
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 20.0)), // Taller button
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0), // Rounded corners
            )
          ),
        ),
          ),
          ),
        ],
      ),
    );
  }

  void _handleSubmit() {
  if (_formKey.currentState?.validate() ?? false) {
    var newReview = Review(
      id: DateTime.now().toString(), // Temporary ID generation
      name: _nameController.text,
      review: _reviewController.text,
      date: _dateController.text,
    );
    // Using context from a Builder or another context ensuring widget in the tree.
    Provider.of<ReviewsProvider>(context, listen: false).addReview(newReview);
    _nameController.clear();
    _reviewController.clear();
    _dateController.clear();

    // Optionally, show a snackbar or another notification that the review was added
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Review added successfully'))
    );
  }
}

 Widget _buildReviewList() {
   double screenWidth = MediaQuery.of(context).size.width;
  return Consumer<ReviewsProvider>(
    builder: (context, provider, child) {
      if (provider.isLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (provider.errorMessage != null) {
        return Center(child: Text(provider.errorMessage!));
      } else if (provider.reviews.isEmpty) {
        return Center(child: Text('No reviews found'));
      }
      return ListView.builder(
        itemCount: provider.reviews.length,
        itemBuilder: (context, index) {
          final review = provider.reviews[index];
          return ListTile(
             key: ValueKey(review.id),
            title: Text(review.name, style:  GoogleFonts.montserrat(fontSize: screenWidth * 0.04,color: Colors.white,fontWeight: FontWeight.bold,)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(review.review, style:  GoogleFonts.montserrat(fontSize: screenWidth * 0.04,color: Color.fromARGB(255, 244, 115, 244),fontWeight: FontWeight.bold,)),
                Text(review.date, style: GoogleFonts.openSans(fontSize: screenWidth * 0.035,color: Color.fromARGB(255, 147, 145, 147),fontWeight: FontWeight.bold,),),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _showEditDialog(context, review),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Color.fromARGB(255, 147, 145, 147)),
                  onPressed: () {
                    provider.removeReview(review.id);
                    // Optionally, confirm deletion
                  },
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

 

 void _showEditDialog(BuildContext context, Review review) {
  var _editNameController = TextEditingController(text: review.name);
  var _editReviewController = TextEditingController(text: review.review);
  var _editDateController = TextEditingController(text: review.date);

  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text('Edit Review'),
        content: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(controller: _editNameController),
              TextFormField(controller: _editReviewController),
              TextFormField(controller: _editDateController),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Review updatedReview = Review(
                id: review.id, // Pastikan menggunakan ID yang sama
                name: _editNameController.text,
                review: _editReviewController.text,
                date: _editDateController.text,
              );
              Provider.of<ReviewsProvider>(context, listen: false).updateReview(review.id, updatedReview);
              Navigator.of(dialogContext).pop();
            },
            child: Text('Update'),
          ),
        ],
      );
    },
  );
}
}