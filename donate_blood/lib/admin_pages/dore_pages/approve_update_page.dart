import 'package:flutter/material.dart';

class RequestApprovalPage extends StatefulWidget {
  const RequestApprovalPage({Key? key});

  @override
  _RequestApprovalPageState createState() => _RequestApprovalPageState();
}

class _RequestApprovalPageState extends State<RequestApprovalPage> {
  // List to store selected requests
  List<bool> selectedRequests = List.generate(5, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 88, 88, 1.0),
        title: const Text('Request Approval'),
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
            const SizedBox(height: 20),
            _buildRequestList(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement logic for approving selected requests
                _processRequests(approve: true);
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                elevation: 20,
                backgroundColor: const Color.fromRGBO(255, 88, 88, 1.0),
                minimumSize: const Size.fromHeight(60),
              ),
              child: const Text(
                'Approve',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Implement logic for declining selected requests
                _processRequests(approve: false);
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                elevation: 20,
                backgroundColor: Colors.red,
                minimumSize: const Size.fromHeight(60),
              ),
              child: const Text(
                'Decline',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigate to the previous page
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                elevation: 20,
                backgroundColor: const Color.fromRGBO(255, 88, 88, 1.0),
                minimumSize: const Size.fromHeight(60),
              ),
              child: const Text(
                'Done',
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

  Widget _buildRequestList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Requests:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(255, 88, 88, 1.0),
          ),
        ),
        const SizedBox(height: 8),
        // Use ListView.builder to create a list of CheckboxListTile
        ListView.builder(
          shrinkWrap: true,
          itemCount: selectedRequests.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              title: Text('Request ${index + 1}'),
              value: selectedRequests[index],
              onChanged: (value) {
                setState(() {
                  selectedRequests[index] = value!;
                });
              },
            );
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _processRequests({required bool approve}) {
    // Implement logic for approving or declining selected requests
    List<int> selectedIndices = [];
    for (int i = 0; i < selectedRequests.length; i++) {
      if (selectedRequests[i]) {
        selectedIndices.add(i);
      }
    }

    // Remove the selected requests from the list
    for (int i in selectedIndices.reversed) {
      selectedRequests.removeAt(i);
    }

    // Clear the selectedRequests list
    selectedRequests = List.generate(5, (index) => false);
  }
}
