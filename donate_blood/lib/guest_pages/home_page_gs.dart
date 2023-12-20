import 'package:donate_blood/d_r_pages/do_request_blood_dr.dart';
import 'package:donate_blood/d_r_pages/request_page_dr.dart';
import 'package:donate_blood/d_r_pages/search_for_history_dr.dart';
import 'package:donate_blood/d_r_pages/user_page_dr.dart';
import 'package:flutter/material.dart';

class HomePageGS extends StatelessWidget {
  const HomePageGS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Updated background color to a red shade
    const myColor = Color.fromRGBO(255, 229, 229, 1.0);

    return Container(
      color: myColor, // Set the background color of the entire page
      child: Scaffold(
        backgroundColor:
            Colors.transparent, // Make the Scaffold background transparent
        body: Stack(
          children: [
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child:
                  _buildTop(), // Display the top section containing an icon and text
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 90),
                  _buildButton(
                    'New Blood Request', // Display button with specific label and color
                    buttonColor: const Color.fromRGBO(255, 88, 88, 1.0),
                    onPressed: () {
                      // Check if the user is authenticated
                      if (isUserAuthenticated()) {
                        // Navigate to the AddDRPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RequestBloodPageDR(),
                          ),
                        );
                      } else {
                        // Show a SnackBar informing the user to log in or create an account
                        _showSnackBar(
                          context,
                          'You must have an account to perform this action.',
                        );
                      }
                    },
                  ),
                  _buildButton(
                    'My History', // Display button with specific label and color
                    buttonColor: const Color.fromRGBO(255, 88, 88, 1.0),
                    onPressed: () {
                      // Check if the user is authenticated
                      if (isUserAuthenticated()) {
                        // Navigate to the SearchHistoryPageDR
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchHistoryPageDR(),
                          ),
                        );
                      } else {
                        // Show a SnackBar informing the user to log in or create an account
                        _showSnackBar(
                          context,
                          'You must have an account to perform this action.',
                        );
                      }
                    },
                  ),
                  _buildButton(
                    'Blood Requests', // Display button with specific label and color
                    buttonColor: const Color.fromRGBO(255, 88, 88, 1.0),
                    onPressed: () {
                      // Check if the user is authenticated
                      if (isUserAuthenticated()) {
                        // Navigate to the RequestPageDR
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RequestPageDR(),
                          ),
                        );
                      } else {
                        // Show a SnackBar informing the user to log in or create an account
                        _showSnackBar(
                          context,
                          'You must have an account to perform this action.',
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build the top section containing an icon and text
  Widget _buildTop() {
    return const SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bloodtype_outlined,
              size: 100, color: Color.fromRGBO(255, 88, 88, 1.0)), // Blood icon
          Text('Be a Lifesaver', // Text encouraging blood donation
              style: TextStyle(
                  color: Color.fromRGBO(255, 88, 88, 1.0),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0)),
        ],
      ),
    );
  }

  // Widget to build a button with a specific label and color
  Widget _buildButton(String label,
      {required Color buttonColor, VoidCallback? onPressed}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: 300,
      height: 70,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.all(15),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }

  // Function to check if the user is authenticated
  bool isUserAuthenticated() {
    // Implement your logic to check if the user is authenticated
    // You may use FirebaseAuth, custom tokens, or any other authentication mechanism
    // Return true if authenticated, false otherwise
    return false; // Change this line based on your authentication logic
  }

  // Function to show a SnackBar
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            // Navigate to the login or account creation page
            // Implement your logic to navigate to the appropriate authentication page
          },
        ),
      ),
    );
  }
}
