import 'package:flutter/material.dart';

class RecipientInfoPage extends StatelessWidget {
  final String recipientId;
  final String bloodType;
  final String amountNeeded;

  const RecipientInfoPage({
    Key? key,
    required this.recipientId,
    required this.bloodType,
    required this.amountNeeded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 88, 88, 1.0),
        title: const Text('Recipient Information'),
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
            _buildInfoWidget('Recipient ID', recipientId),
            _buildInfoWidget('Blood Type', bloodType),
            _buildInfoWidget('Amount of Blood Needed', amountNeeded),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoWidget(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
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
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
