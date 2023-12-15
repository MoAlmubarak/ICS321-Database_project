import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReportDashboardPage extends StatelessWidget {
  const ReportDashboardPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 88, 88, 1.0),
        title: const Text('Report Dashboard'),
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
            _buildReportItem(
              'Blood Donations in a Week/Month',
              'List of all blood donations received in a week or month',
            ),
            _buildReportItem(
              'Total Amount by Blood Type',
              'List of the total amount available for each blood type',
            ),
            _buildReportItem(
              'Collection Drives and Total Blood',
              'List all collection drives and the total blood for each one',
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement logic for generating the report
                // You may navigate to a new page or display the report here.
                // For simplicity, let's just navigate to the HomeScreen.
                Navigator.pop(context);
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

  Widget _buildReportItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 3,
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(255, 88, 88, 1.0),
            ),
          ),
          subtitle: Text(description),
        ),
      ),
    );
  }
}
