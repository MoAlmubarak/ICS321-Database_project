import 'package:donate_blood/d_r_pages/home_screen_dr.dart';
import 'package:donate_blood/guest_pages/home_screen_gs.dart';
import 'package:flutter/material.dart';

class RequestPageGS extends StatelessWidget {
  RequestPageGS({Key? key}) : super(key: key);

  // Dummy data for requested blood donation
  // final requestedDonation = {
  //   'recipientId': '123456',
  //   'bloodType': 'A+',
  //   'amount': '300 ml',
  // };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 88, 88, 1.0),
        title: const Text('Requested Blood Donation'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            // Navigate to the HomeScreenGS
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreenGS(),
              ),
            );
          },
        ),
      ),
      backgroundColor: const Color.fromRGBO(255, 229, 229, 1.0),
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.stretch,
      //     children: [
      //       _buildInfoWidget('Requested Blood Donation', requestedDonation),
      //       const SizedBox(height: 20),
      //       _buildRequestInfoForGuest(context),
      //     ],
      //   ),
      // ),
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

  Widget _buildRequestInfoForGuest(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Request Information',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(255, 88, 88, 1.0),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'To view request details, please sign in or create an account.',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
