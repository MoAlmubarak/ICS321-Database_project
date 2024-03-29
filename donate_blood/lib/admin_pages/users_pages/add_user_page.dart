import 'package:donate_blood/Database/sqlite_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key, required this.title});

  final String title;

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  // Create controllers for each text field
  final typeController = TextEditingController();

  final firstNameController = TextEditingController();

  final lastNameController = TextEditingController();

  final addressController = TextEditingController();

  final contactNumberController = TextEditingController();

  final emailController = TextEditingController();

  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final SQFLiteDatabase database = SQFLiteDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 88, 88, 1.0),
        title: const Text('Add User'),
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
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                        'Type',
                        [
                          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
                        ],
                        controller: typeController),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                        'First Name',
                        [
                          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
                        ],
                        controller: firstNameController),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                        'Last Name',
                        [
                          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
                        ],
                        controller: lastNameController),
                  ),
                ],
              ),
              _buildTextField('Address',
                  [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))],
                  controller: addressController),
              _buildTextField(
                  'Contact Number',
                  [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10) // Limit to 10 digits
                  ],
                  controller: contactNumberController),
              _buildTextField('Email', [], controller: emailController),
              _buildTextField('Username', [], controller: usernameController),
              _buildTextField('Password', [], controller: passwordController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_areAllFieldsFilled([
                    typeController,
                    firstNameController,
                    lastNameController,
                    addressController,
                    contactNumberController,
                    emailController,
                    usernameController,
                    passwordController
                  ])) {
                    // for adding a user.
                    _addUserToDatabase();

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
                  'Add',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showUsers();
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  elevation: 20,
                  backgroundColor: const Color.fromRGBO(255, 88, 88, 1.0),
                  minimumSize: const Size.fromHeight(60),
                ),
                child: const Text(
                  'Show users',
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
  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('User added successfully!'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            // Navigate to the HomeScreen page
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

  void _addUserToDatabase() async {
    Map<String, dynamic> person = {
      "Type": typeController.text,
      "FirstName": firstNameController.text,
      "LastName": lastNameController.text,
      "Address": addressController.text,
      "ContactNumber": contactNumberController.text,
      "Email": emailController.text,
      "Username": usernameController.text,
      "Password": passwordController.text
    };

    await database.insertPerson(person);
    final persons = await database.getAllPersons();

    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    print('persons:');
    for (final person in persons) {
      print(person);
    }
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
  }

  void _showUsers() async {
    final persons = await database.getAllPersons();

    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    print('persons:');
    for (final person in persons) {
      print(person);
    }
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
  }
}
