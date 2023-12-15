import 'package:donate_blood/pages/dore_pages/edit_d_r_page.dart';
import 'package:donate_blood/pages/dore_pages/search_history_d_r_page2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IdSearchHistoryPage extends StatelessWidget {
  const IdSearchHistoryPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final idController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 88, 88, 1.0),
        title: const Text('Search Donor/Recipient History'),
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
                  // Navigate to the AddDRPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchHistoryPage(),
                    ),
                  );
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
                'Search',
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
}
