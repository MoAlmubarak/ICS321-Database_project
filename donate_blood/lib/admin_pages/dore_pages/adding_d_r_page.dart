import 'package:donate_blood/Database/sqlite_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddDRPage extends StatefulWidget {
  const AddDRPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddDRPageState createState() => _AddDRPageState();
}

class _AddDRPageState extends State<AddDRPage> {
  // Create controllers for each text field
  final idController = TextEditingController();

  final typeController = TextEditingController();

  final firstNameController = TextEditingController();

  final lastNameController = TextEditingController();

  final weightController = TextEditingController();

  final birthDateController = TextEditingController();

  final addressController = TextEditingController();

  final contactNumberController = TextEditingController();

  final emailController = TextEditingController();

  final medicalHistoryController = TextEditingController();

  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final SQFLiteDatabase database = SQFLiteDatabase();

  bool idTextFieldIsInteractive = true;
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 88, 88, 1.0),
        title: const Text('Add Donor/Recipient'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            // Navigate to the previous page (DRPage)
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color.fromRGBO(255, 229, 229, 1.0),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField('ID', [FilteringTextInputFormatter.digitsOnly],
                  controller: idController,
                  isInteractive: idTextFieldIsInteractive),
              Visibility(
                visible: isVisible,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                              'Type',
                              [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z]'))
                              ],
                              controller: typeController,
                              isInteractive: true),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                              'First Name',
                              [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z]'))
                              ],
                              controller: firstNameController,
                              isInteractive: true),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildTextField(
                              'Last Name',
                              [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z]'))
                              ],
                              controller: lastNameController,
                              isInteractive: true),
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
                                LengthLimitingTextInputFormatter(
                                    10) // Limit to 10 digits
                              ],
                              controller: weightController,
                              isInteractive: true),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildTextField('Birth Date', [],
                              controller: birthDateController,
                              isInteractive: true),
                        ),
                      ],
                    ),
                    _buildTextField(
                        'Address',
                        [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z0-9]'))
                        ],
                        controller: addressController,
                        isInteractive: true),
                    _buildTextField(
                        'Contact Number',
                        [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(
                              10) // Limit to 10 digits
                        ],
                        controller: contactNumberController,
                        isInteractive: true),
                    _buildTextField('Email', [],
                        controller: emailController, isInteractive: true),
                    _buildTextField('Medical History', [],
                        controller: medicalHistoryController,
                        isInteractive: true),
                    _buildTextField('Username', [],
                        controller: usernameController, isInteractive: true),
                    _buildTextField('Password', [],
                        controller: passwordController, isInteractive: true),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_areAllFieldsFilled([
                          idController,
                          typeController,
                          firstNameController,
                          lastNameController,
                          weightController,
                          birthDateController,
                          addressController,
                          contactNumberController,
                          emailController,
                          medicalHistoryController,
                          usernameController,
                          passwordController
                        ])) {
                          setState(() {
                            isVisible = !isVisible;
                            idTextFieldIsInteractive =
                                !idTextFieldIsInteractive;
                          });

                          _addDonorRecipient();
                          _showUsers();
                          idController.clear();
                          _showSnackBar(context);
                          Future.delayed(const Duration(seconds: 1), () {
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
                  ],
                ),
              ),
              Visibility(
                visible: !isVisible,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_areAllFieldsFilled([idController])) {
                          final persons = await database.getAllPersons();
                          final donors = await database.getDonors();

                          int selectedPersonId = int.parse(idController.text);
                          // ignore: avoid_print
                          print("selectedPersonId: $selectedPersonId");
                          bool donorFound = false;
                          bool personFound = false;

                          for (final person in persons) {
                            if (selectedPersonId == person["Id"]) {
                              personFound = true;

                              typeController.text = person["Type"];
                              firstNameController.text = person["FirstName"];
                              lastNameController.text = person["LastName"];
                              addressController.text = person["Address"];
                              contactNumberController.text =
                                  person["ContactNumber"];
                              emailController.text = person["Email"];
                              usernameController.text = person["Username"];
                              passwordController.text = person["Password"];

                              for (final donor in donors) {
                                if (selectedPersonId == donor["DonorId"]) {
                                  donorFound = true;
                                }
                              }
                            }
                          }
                          if (!donorFound && personFound) {
                            setState(() {
                              isVisible = !isVisible;
                              idTextFieldIsInteractive =
                                  !idTextFieldIsInteractive;
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'no person with this ID. please enter another ID.'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
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
                        'Insert ID',
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String labelText, List<TextInputFormatter>? inputFormatters,
      {required TextEditingController controller,
      required bool isInteractive}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        enabled: isInteractive,
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
            // take me to the HomeScreen page
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

  void _addDonorRecipient() async {
    Map<String, dynamic> personInfo = {
      "Type": typeController.text,
      "FirstName": firstNameController.text,
      "LastName": lastNameController.text,
      "Address": addressController.text,
      "ContactNumber": contactNumberController.text,
      "Email": emailController.text,
      "Username": usernameController.text,
      "Password": passwordController.text
    };

    Map<String, dynamic> medicalHistory = {
      "HistoryId": int.parse(idController.text),
      "MedicalHistory": medicalHistoryController.text,
    };

    Map<String, dynamic> donorInfo = {
      "BirthDate": birthDateController.text,
      "Weight": int.parse(weightController.text),
      "DonorId": idController.text,
      "HistoryId": int.parse(idController.text),
    };

    await database.updatePerson(personInfo);
    await database.insertDonor(donorInfo);
    await database.insertMedicalHistory(medicalHistory);
  }

  void _showUsers() async {
    final persons = await database.getAllPersons();

    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    print('persons:');
    for (final person in persons) {
      print(person);
    }
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

    final donors = await database.getDonors();

    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    print('donors:');
    for (final donor in donors) {
      print(donor);
    }
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

    final medicalHistorys = await database.getMedicalHistories();

    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    print('medicalHistorys:');
    for (final medicalHistory in medicalHistorys) {
      print(medicalHistory);
    }
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
  }
}
