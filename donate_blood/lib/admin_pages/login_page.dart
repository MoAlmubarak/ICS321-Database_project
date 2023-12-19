import 'package:donate_blood/Database/sqlite_database.dart';
import 'package:donate_blood/d_r_pages/home_screen_dr.dart';
import 'package:flutter/material.dart';
import 'package:donate_blood/admin_pages/homePages/home_screen.dart'; // Import the HomeScreen class or update the import statement accordingly

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Set the color theme to match the home page
    myColor = const Color.fromRGBO(255, 229, 229, 1.0);
    mediaSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 88, 88, 1.0),
      body: Stack(
        children: [
          Positioned(
            top: 80,
            child: _buildTop(),
          ),
          Positioned(
            bottom: 0,
            child: _buildBottom(),
          ),
        ],
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bloodtype_outlined, size: 100, color: Colors.white),
          Text('Donate Blood',
              style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: 2.0)),
          Text(
            'وَمَنْ أَحْيَاهَا فَكَأَنَّمَا أَحْيَا النَّاسَ جَمِيعاً',
            style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        color: myColor,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Welcome',
          style: TextStyle(
              color: Color.fromRGBO(255, 88, 88, 1.0), fontSize: 30, fontWeight: FontWeight.w500, letterSpacing: 2.0),
        ),
        _buildRedText(
          'Please, login with your information',
        ),
        const SizedBox(height: 60),
        _buildRedText('Username'),
        _buildInputField(usernameController),
        const SizedBox(height: 40),
        _buildRedText('Password'),
        _buildInputField(passwordController, isPassword: true),
        const SizedBox(height: 20),
        _buildLoginButton(),
        const SizedBox(height: 20),
        _buildLogAsGuestButton(),
      ],
    );
  }

  Widget _buildRedText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 15, color: Color.fromRGBO(255, 88, 88, 1.0)),
    );
  }

  Widget _buildInputField(TextEditingController controller, {isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword ? const Icon(Icons.remove_red_eye_outlined) : const Icon(Icons.done),
      ),
      obscureText: isPassword,
    );
  }

  // Widget _buildLoginButton() {
  //   return ElevatedButton(
  //     onPressed: () {
  //       // Navigate to the HomeScreen when the login button is pressed
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => HomeScreen()),
  //       );
  //     },
  //     style: ElevatedButton.styleFrom(
  //       shape: const StadiumBorder(),
  //       elevation: 20,
  //       backgroundColor: const Color.fromRGBO(255, 88, 88, 1.0),
  //       minimumSize: const Size.fromHeight(60),
  //     ),
  //     child: const Text('LOGIN',
  //         style: TextStyle(
  //             fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
  //   );
  // }
  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () async {
        final SQFLiteDatabase database = SQFLiteDatabase();

        final person = {
          'Type': 'Donor',
          'FirstName': 'John',
          'LastName': 'Doe',
          'Address': '123 Main St',
          'ContactNumber': '555-1234',
          'Email': 'johndoe@example.com',
          'Username': 'johndoe',
          'Password': 'password123',
        };

        await database.insertPerson(person);
        final medicalHistory = {
          'HistoryId': 2,
          'MedicalHistory': 'No significant medical history',
        };

        await database.insertMedicalHistory(medicalHistory);
        final bloodType = {
          'BloodId': 1,
          'Type': 'A+',
        };

        await database.insertBloodType(bloodType);
        final compatibleType = {
          'compatibleType': 'A+',
          'BloodId': 1,
        };

        await database.insertCompatibleType(compatibleType);
        final donor = {
          'BirthDate': '1990-01-01',
          'Weight': 70,
          'DonorId': 1,
          'HistoryId': 1,
        };

        await database.insertDonor(donor);
        final donation = {
          'DonationId': 1,
          'DonationDate': '2023-12-19',
          'ExpirationDate': '2024-01-19',
          'DonateAmount': 1,
          'Status': 'Received',
          'AdminId': 1,
          'DonorId': 1,
        };

        await database.insertDonation(donation);
        final received = {
          'ReceivedAmount': 1,
          'DonationId': 1,
          'ReceivedId': 1,
        };

        await database.insertReceived(received);

        final recipient = {
          'RecipientId': 1,
          'HistoryId': 1,
          'ReceivedAmount': 1,
        };

        await database.insertRecipient(recipient);
        final requestBlood = {
          'RequestId': 1,
          'RecipientId': 1,
          'BloodId': 1,
          'BloodAmount': 1,
          'IsApproved': 1,
        };

        await database.insertRequestBlood(requestBlood);
        final collectionDrive = {
          'DriveId': 1,
          'CollectedAmount': 1,
          'TargetAmount': 10,
          'StartDate': '2023-12-01',
          'EndDate': '2023-12-31',
          'CampaignType': 'Blood Drive',
        };

        await database.insertBloodCollectionDrive(collectionDrive);
        print('presons');
        print(await database.getAllPersons());
        print(await database.getBloodTypes());
        print(await database.getDonations());
// and so on  no futher example needed .................................

        // String username = usernameController.text.toLowerCase();

        // if (username.contains('admin')) {
        //   // Navigate to HomeScreen for admin
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => const HomeScreen()),
        //   );
        // } else if (username.contains('donor') ||
        //     username.contains('recipient')) {
        //   // Navigate to HomeScreenDR for donor/recipient
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => const HomeScreenDR()),
        //   );
        // } else {
        //   // Handle other cases or display a message
        //   _showSnackBar(context, 'Invalid username');
        // }
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        backgroundColor: const Color.fromRGBO(255, 88, 88, 1.0),
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text(
        'LOGIN',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildLogAsGuestButton() {
    return ElevatedButton(
      onPressed: () {
        debugPrint('You are logged in as a guest');
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        backgroundColor: const Color.fromRGBO(255, 88, 88, 1.0),
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text('AS GUEST', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }
}
