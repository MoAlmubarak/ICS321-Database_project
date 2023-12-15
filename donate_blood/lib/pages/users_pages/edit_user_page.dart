import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditUserPage extends StatelessWidget {
  const EditUserPage({Key? key});

  @override
  Widget build(BuildContext context) {
    // Create controllers for each text field
    final currentUsernameController = TextEditingController();
    final currentPasswordController = TextEditingController();
    final newUsernameController = TextEditingController();
    final newPasswordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 88, 88, 1.0),
        title: const Text('Edit User'),
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
            _buildTextField('Current Username',
                controller: currentUsernameController),
            _buildTextField('Current Password',
                controller: currentPasswordController, isPassword: true),
            _buildTextField('New Username', controller: newUsernameController),
            _buildTextField('New Password',
                controller: newPasswordController, isPassword: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_areAllFieldsFilled([
                  currentUsernameController,
                  currentPasswordController,
                  newUsernameController,
                  newPasswordController,
                ])) {
                  _showSnackBar(context);
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.pop(context);
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill all the fields'),
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
                'Update',
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

  Widget _buildTextField(String labelText,
      {required TextEditingController controller, bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
        controller: controller,
      ),
    );
  }

  // Function to show a SnackBar
  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('User updated successfully!'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            // Navigate to the HomeScreen page or any other desired page
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  // Function to check if all fields are filled
  bool _areAllFieldsFilled(List<TextEditingController> controllers) {
    return controllers.every((controller) => controller.text.isNotEmpty);
  }
}
