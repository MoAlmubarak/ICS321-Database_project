import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SendMessagePage extends StatelessWidget {
  const SendMessagePage({Key? key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final messageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 88, 88, 1.0),
        title: const Text('Send Message to all users'),
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
              'Title',
              [],
              controller: titleController,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              'Message',
              [],
              maxLines: 3,
              controller: messageController,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    messageController.text.isNotEmpty) {
                  _sendMessage(
                    context,
                    titleController.text,
                    messageController.text,
                  );
                  // make a delay of 3 seconds
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
                'Send Message',
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
    int? maxLines,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        inputFormatters: inputFormatters,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
        controller: controller,
      ),
    );
  }

  void _sendMessage(BuildContext context, String title, String message) {
    // TODO: Implement logic to send a message to all users' emails with the provided title and message
    // You may use a messaging service or send emails, depending on your requirements.

    _showSnackBar(context, 'Message sent successfully!');
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
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
