import 'package:donate_blood/d_r_pages/home_screen_dr.dart';
import 'package:flutter/material.dart';

class RequestPageDR extends StatefulWidget {
  const RequestPageDR({Key? key}) : super(key: key);

  @override
  _RequestPageDRState createState() => _RequestPageDRState();
}

class _RequestPageDRState extends State<RequestPageDR> {
  // Dummy data for requested blood donation
  final requestedDonation = {
    'recipientId': '123456',
    'bloodType': 'A+',
    'amount': '300 ml',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 88, 88, 1.0),
        title: const Text('Requested Blood Donation'),
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
            _buildInfoWidget('Requested Blood Donation', requestedDonation),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _handleAgree(context);
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                elevation: 20,
                backgroundColor: const Color.fromRGBO(0, 204, 102, 1.0),
                minimumSize: const Size.fromHeight(60),
              ),
              child: const Text(
                'Agree',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _handleDecline(context);
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                elevation: 20,
                backgroundColor: Colors.red,
                minimumSize: const Size.fromHeight(60),
              ),
              child: const Text(
                'Decline',
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

  void _handleAgree(BuildContext context) {
    // TODO: Implement logic for donor agreeing to the requested donation
    _showSnackBar(context, 'You agreed to the donation.');
    // Simulate hiding the request and returning to the previous page after a delay
    _simulateActionCompletionAndNavigateBack(context);
  }

  void _handleDecline(BuildContext context) {
    // TODO: Implement logic for donor declining the requested donation
    _showSnackBar(context, 'You declined the donation.');
    // Simulate hiding the request and returning to the previous page after a delay
    _simulateActionCompletionAndNavigateBack(context);
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            // Take me to the HomeScreen page or the previous page
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  // Simulate action completion and navigate back after a delay
  void _simulateActionCompletionAndNavigateBack(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreenDR(),
        ),
      );

      // Navigator.pop(context);
    });
  }
}
