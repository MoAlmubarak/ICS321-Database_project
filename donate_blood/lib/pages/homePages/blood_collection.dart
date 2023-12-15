import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BloodCollectionDrivePage extends StatefulWidget {
  const BloodCollectionDrivePage({Key? key}) : super(key: key);

  @override
  _BloodCollectionDrivePageState createState() =>
      _BloodCollectionDrivePageState();
}

class _BloodCollectionDrivePageState extends State<BloodCollectionDrivePage> {
  // Create controllers for each text field
  final amountController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final campaignTypeController = TextEditingController();

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != controller.text) {
      setState(() {
        controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 88, 88, 1.0),
        title: const Text('Blood Collection Drive'),
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
            _buildTextField(
              'The amount of blood targeted (ml/L)',
              [FilteringTextInputFormatter.digitsOnly],
              controller: amountController,
            ),
            _buildDateField('Start From', startDateController),
            _buildDateField('End In', endDateController),
            _buildTextField(
              'Campaign Type',
              [],
              controller: campaignTypeController,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_areAllFieldsFilled([
                  amountController,
                  startDateController,
                  endDateController,
                  campaignTypeController,
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
                'Create Blood Drive',
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

  Widget _buildTextField(
    String labelText,
    List<TextInputFormatter>? inputFormatters, {
    required TextEditingController controller,
  }) {
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

  Widget _buildDateField(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                labelText: labelText,
                border: const OutlineInputBorder(),
              ),
              controller: controller,
              enabled: false,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.date_range),
            onPressed: () {
              _selectDate(context, controller);
            },
          ),
        ],
      ),
    );
  }

  // Function to show a SnackBar
  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Blood Collection Drive created successfully!'),
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
}
