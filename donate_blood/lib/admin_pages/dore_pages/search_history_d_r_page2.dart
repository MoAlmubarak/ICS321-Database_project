import 'package:donate_blood/admin_pages/homePages/home_screen.dart';
import 'package:flutter/material.dart';

class SearchHistoryPage extends StatelessWidget {
  const SearchHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for Donor/Recipient information
    const donorRecipientInfo = {
      'id': '123456',
      'firstName': 'John',
      'lastName': 'Doe',
    };

    // Dummy data for donation and received blood information
    const donationInfo = {
      'donationCount': 5,
      'donationAmount': '500 ml',
      'receivedBloodCount': 3,
      'receivedBloodAmount': '300 ml',
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 88, 88, 1.0),
        title: const Text('Donor/Recipient History'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            // Navigate to the previous page (DRPage)
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color.fromRGBO(255, 229, 229, 1.0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInfoWidget('Donor/Recipient Info', donorRecipientInfo),
            _buildInfoWidget('Donation and Received Blood Info', donationInfo),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the HomeScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                elevation: 20,
                backgroundColor: const Color.fromRGBO(255, 88, 88, 1.0),
                minimumSize: const Size.fromHeight(60),
              ),
              child: const Text(
                'Done',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoWidget(String title, Map<String, dynamic> info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(255, 88, 88, 1.0),
          ),
        ),
        const SizedBox(height: 8),
        ...info.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${entry.key}:',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  entry.value.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 16),
      ],
    );
  }
}
