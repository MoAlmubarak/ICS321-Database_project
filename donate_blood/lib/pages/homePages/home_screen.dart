import 'package:donate_blood/pages/homePages/donor_recipient_page.dart';
import 'package:donate_blood/pages/homePages/home_page.dart';
import 'package:donate_blood/pages/homePages/user_page.dart';
import 'package:donate_blood/pages/homePages/users_page.dart';
import 'package:donate_blood/pages/login_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variable to track the index of the selected page in the bottom navigation bar
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 88, 88, 1.0),
        title: const Text('Home'),
        // Add the logout button to the top-left corner
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () {
            // Handle logout logic
            // You can add your logout logic here
            // For example, navigate to the login page
            // Navigator.popUntil(context, ModalRoute.withName('/login'));
            // Navigate to the HomeScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          },
        ),
      ),
      // Body of the app displays the selected page
      body: _getPages(),
      // Bottom navigation bar for navigating between pages
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  // Widget for creating the bottom navigation bar
  _bottomNavigationBar() {
    return BottomNavigationBar(
      // List of navigation bar items with icons and labels
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 30), // Icon for the 'Home' page
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bloodtype_outlined,
              size: 30), // Icon for the 'D/R' page
          label: 'D/R',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, size: 30), // Icon for the 'Users' page
          label: 'Users',
        ),
      ],
      // Current index of the selected page
      currentIndex: selectedPage,
      // Callback function to handle taps on navigation bar items
      onTap: (tappedPage) {
        setState(() {
          selectedPage = tappedPage;
        });
      },
      // Styling properties for the bottom navigation bar
      backgroundColor:
          const Color.fromRGBO(255, 194, 194, 1.0), // Background color
      selectedItemColor: const Color.fromRGBO(
          255, 88, 88, 1.0), // Color of the selected item (active page)
      unselectedItemColor:
          Colors.grey, // Color of unselected items (inactive pages)
      selectedFontSize: 16.0, // Font size of the selected item label
      unselectedFontSize: 14.0, // Font size of unselected item labels
    );
  }

  // Function to get the widget for the selected page
  _getPages() {
    switch (selectedPage) {
      case 0:
        return const HomePage(); // Display the 'Home' page
      case 1:
        return const DRPage(); // Display the 'D/R' page
      case 2:
        return const UserPage(); // Display the 'Users' page
    }
  }
}
