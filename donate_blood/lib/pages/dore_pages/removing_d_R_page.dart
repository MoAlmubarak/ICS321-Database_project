import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RemoveDRPage extends StatelessWidget {
  const RemoveDRPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final idController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 88, 88, 1.0),
        title: const Text('Remove Donor/Recipient'),
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
            _buildTextField('ID', [FilteringTextInputFormatter.digitsOnly],
                controller: idController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (idController.text.isNotEmpty) {
                  _showSnackBar(context);
                  // make a delay of 3 seconds
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.pop(context);
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill the ID field'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                elevation: 20,
                backgroundColor: const Color.fromRGBO(255, 88, 88, 1.0),
                minimumSize: const Size.fromHeight(60),
              ),
              child: const Text(
                'Remove',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
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

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('User removed successfully!'),
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
}
