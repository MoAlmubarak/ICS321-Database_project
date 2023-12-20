import 'package:donate_blood/d_r_pages/home_screen_dr.dart';
import 'package:donate_blood/guest_pages/home_screen_gs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserPageGS extends StatelessWidget {
  const UserPageGS({Key? key});

  @override
  Widget build(BuildContext context) {
    // Create controllers for each text field
    final idController = TextEditingController();
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final weightController = TextEditingController();
    final birthDateController = TextEditingController();
    final addressController = TextEditingController();
    final contactNumberController = TextEditingController();
    final emailController = TextEditingController();
    final medicalHistoryController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 88, 88, 1.0),
        title: const Text('Edit Personal Information'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            // Navigate to the HomeScreenDR
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                'ID',
                [FilteringTextInputFormatter.digitsOnly],
                controller: idController,
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      'First Name',
                      [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))],
                      controller: firstNameController,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                      'Last Name',
                      [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))],
                      controller: lastNameController,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      'Weight',
                      [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      controller: weightController,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                      'Birth Date',
                      [],
                      controller: birthDateController,
                    ),
                  ),
                ],
              ),
              _buildTextField(
                'Address',
                [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))],
                controller: addressController,
              ),
              _buildTextField(
                'Contact Number',
                [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                controller: contactNumberController,
              ),
              _buildTextField('Email', [], controller: emailController),
              _buildTextField(
                'Medical History',
                [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))],
                controller: medicalHistoryController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Check if the user is authenticated
                  if (isUserAuthenticated()) {
                    if (_areAllFieldsFilled([
                      idController,
                      firstNameController,
                      lastNameController,
                      weightController,
                      birthDateController,
                      addressController,
                      contactNumberController,
                      emailController,
                      medicalHistoryController,
                    ])) {
                      _showSnackBar(
                          context, 'Request has been sent to the admin');
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
                  } else {
                    // Show a SnackBar informing the user to log in or create an account
                    _showSnackBar(
                      context,
                      'You must have an account to save changes.',
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
                  'Save Changes',
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

  // Function to show a SnackBar
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            // Take me to the HomeScreenDR page
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

  // Function to check if the user is authenticated (dummy implementation)
  bool isUserAuthenticated() {
    // Replace this with your authentication logic
    return false;
  }
}
