import 'package:donate_blood/admin_pages/dore_pages/adding_d_r_page.dart';
import 'package:donate_blood/admin_pages/dore_pages/approve_update_page.dart';
import 'package:donate_blood/admin_pages/dore_pages/id_to_update.dart';
import 'package:donate_blood/admin_pages/dore_pages/removing_d_R_page.dart';
import 'package:donate_blood/admin_pages/dore_pages/search_history_d_r_page.dart';
import 'package:flutter/material.dart';
// import 'package:your_app_name_here/pages/add_dr_page.dart'; // Make sure to import the correct file

class DRPage extends StatelessWidget {
  const DRPage({Key? key}) : super(key: key);

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
                  const SizedBox(height: 180),
                  _buildButton(
                    'Add D/R', // Display button with specific label and color
                    buttonColor: const Color.fromRGBO(255, 88, 88, 1.0),
                    onPressed: () {
                      // Navigate to the AddDRPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddDRPage(),
                        ),
                      );
                    },
                  ),
                  _buildButton(
                    'Remove D/R', // Display button with specific label and color
                    buttonColor: const Color.fromRGBO(255, 88, 88, 1.0),
                    onPressed: () {
                      // Navigate to the AddDRPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RemoveDRPage(),
                        ),
                      );
                    },
                  ),
                  _buildButton(
                    'Edit D/R', // Display button with specific label and color
                    buttonColor: const Color.fromRGBO(255, 88, 88, 1.0),
                    onPressed: () {
                      // Navigate to the AddDRPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const IdRemovePage(),
                        ),
                      );
                    },
                  ),
                  _buildButton(
                    'Search D/R History', // Display button with specific label and color
                    buttonColor: const Color.fromRGBO(255, 88, 88, 1.0),
                    onPressed: () {
                      // Navigate to the AddDRPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const IdSearchHistoryPage(),
                        ),
                      );
                    },
                  ),
                  _buildButton(
                    'Approve Updates', // Display button with specific label and color
                    buttonColor: const Color.fromRGBO(255, 88, 88, 1.0),
                    onPressed: () {
                      // Navigate to the AddDRPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RequestApprovalPage(),
                        ),
                      );
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
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: const Color.fromRGBO(255, 88, 88, 1.0),
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
}
