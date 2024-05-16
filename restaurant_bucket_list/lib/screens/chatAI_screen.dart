import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_bucket_list/ViewModel/navigation.dart';
import 'package:restaurant_bucket_list/env/env.dart';
class ChatAI extends StatefulWidget {
  const ChatAI({super.key});

  @override
  State<ChatAI> createState() => _ChatAIState();
}

class _ChatAIState extends State<ChatAI> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _textController = TextEditingController();
  String _response = '';
  @override
  Widget build(BuildContext context) {
     double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
       backgroundColor: Color(0xFF16181F),
       appBar: AppBar(
        automaticallyImplyLeading: false,
        title:  Text('Chat with AI', style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold,color:Colors.white),
        key: Key("judul Page AI"),
        ),
        centerTitle: false,
        backgroundColor: Color(0xFF262A36),
         shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),  // Define the radius of the curve here
    ),
  ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                key: Key("Field Pesan"),
                cursorColor: Colors.white,
                controller: _textController,
                style:  GoogleFonts.montserrat(fontSize: screenWidth * 0.04,color: Colors.white,fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                   labelText: 'Type your message here',
                   labelStyle: GoogleFonts.montserrat(
                  color: Color.fromARGB(255, 248, 240, 240), // Set the label text color to white
                  fontSize: screenWidth * 0.04,
                  fontWeight:FontWeight.bold// Consistent font size with input text
              ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 108, 98, 98),
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(20.0), // Sudut bulat
                      borderSide: BorderSide.none, // Tanpa border luar
                   ),
                   contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 20), 
                ),
              ),
               SizedBox(height: 20),
              ElevatedButton(
                key: Key("Submit Button"),
                onPressed: _submitForm,
                child: const Text('Submit'),
                style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.deepPurple), // Warna background
            foregroundColor: MaterialStateProperty.all(Colors.white), // Warna teks
            padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30, vertical: 15)), // Padding
            shape: MaterialStateProperty.all<RoundedRectangleBorder>( // Sudut bulat
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              )
            )
          ),
              ),
              SizedBox(height: 20),
              Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
             child:  Text(_response, 
              style: GoogleFonts.montserrat(
                  color: Color.fromARGB(255, 248, 240, 240), // Set the label text color to white
                  fontSize: screenWidth * 0.04,
                  fontWeight:FontWeight.bold// Consistent font size with input text
              ),
              ),
              ),
            ],
          ),
        ),
      ),
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
  }
  ),
  );
  }
  void _submitForm() async {
    print("input user : " + _textController.text.trim());
     final apiKey = Env.apiKey;
    //final apiKey = key;
    // const apiUrl = 'https://api.openai.com/v1/completions';
    const apiUrl = 'https://api.openai.com/v1/chat/completions';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
        'Authorization': 'Bearer $apiKey'
      },
      body: jsonEncode(
        <String, dynamic>{
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "user",
              "content":
                  "ini merupakan pertanyaan user tolong jawab dengan mudah di mengerti ${_textController} gunakan data berikut sebagai data kamu nanti " // ada lagi ?
            }
          ],
          'max_tokens': 250,
        },
      ),
    );
   if (response.statusCode == 200) {
    // Berhasil mendapatkan respons dari server
    final responseData = jsonDecode(response.body);
    print('Respon sukses: ${responseData.toString()}');

    // Memperoleh isi dari content
    if (responseData.containsKey('choices') && responseData['choices'].isNotEmpty) {
      setState(() {
        // Memperbarui _response dengan isi dari content
        _response = responseData['choices'][0]['message']['content'].toString();
      });
    } else {
      print('Gagal mendapatkan isi konten dari respons.');
    }
  } else {
    // Gagal mendapatkan respons dari server
    print('Gagal mendapatkan respons. Kode status: ${response.body}');
  }
  }
}