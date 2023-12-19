import 'package:donate_blood/d_r_pages/home_screen_dr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RequestBloodPageDR extends StatelessWidget {
  RequestBloodPageDR({super.key, superKey});

  final TextEditingController recipientIdController = TextEditingController();
  final TextEditingController bloodTypeController = TextEditingController();
  final TextEditingController bloodAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const myColor = Color.fromRGBO(255, 229, 229, 1.0);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 88, 88, 1.0),
        title: const Text('New Blood Request'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            // Navigate to the AddDRPage
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreenDR(),
              ),
            );
          },
        ),
      ),
      backgroundColor: myColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(
              'Recipient ID',
              [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10), // Limit to 10 digits
              ],
              controller: recipientIdController,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              'Blood Type',
              [FilteringTextInputFormatter.allow(RegExp(r'[ABO+-]'))],
              controller: bloodTypeController,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              'Blood Amount (ml)',
              [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(5), // Limit to 5 digits
              ],
              controller: bloodAmountController,
            ),
            const SizedBox(height: 40),
            _buildButton(
              'Send Request',
              buttonColor: const Color.fromRGBO(255, 88, 88, 1.0),
              onPressed: () {
                if (_areFieldsValid()) {
                  // TODO: Handle sending the blood request logic

                  // Show SnackBar for successful request
                  _showSnackBar(context, 'Request sent successfully!');
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.pop(context);
                  });
                } else {
                  _showSnackBar(context, 'Please fill all the fields');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String labelText, List<TextInputFormatter>? inputFormatters,
      {required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
        controller: controller,
      ),
    );
  }

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

  // Function to check if all fields are filled
  bool _areFieldsValid() {
    return recipientIdController.text.isNotEmpty &&
        bloodTypeController.text.isNotEmpty &&
        bloodAmountController.text.isNotEmpty;
  }

  // Function to show a SnackBar
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
