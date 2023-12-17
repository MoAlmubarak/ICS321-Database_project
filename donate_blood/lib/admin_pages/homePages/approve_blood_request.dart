import 'package:donate_blood/admin_pages/homePages/approve_blood_request2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BloodRequestsPage extends StatelessWidget {
  const BloodRequestsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 88, 88, 1.0),
        title: const Text('Blood Requests'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            // Navigate to the previous page
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
            _buildRequestCard('Request 1'), // Replace with actual request data
            _buildRequestCard('Request 2'), // Replace with actual request data
            _buildRequestCard('Request 3'), // Replace with actual request data
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement logic for selecting a request and proceeding
                // For now, let's just navigate to the next page (EditDRPage)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RecipientInfoPage(
                      recipientId: '12',
                      bloodType: 'B+',
                      amountNeeded: '120',
                    ),
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
                'Next',
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

  Widget _buildRequestCard(String requestData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 3,
        child: ListTile(
          title: Text(
            requestData,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(255, 88, 88, 1.0),
            ),
          ),
          subtitle: Text('Request details'), // Replace with actual details
          onTap: () {
            // Implement logic to select this request
            // This could be setting state, updating a variable, etc.
          },
        ),
      ),
    );
  }
}
