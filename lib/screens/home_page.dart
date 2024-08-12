
import 'package:cell_number_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'assignment_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _cellNumbers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome To Silux Mobile'),
        backgroundColor: Colors.green, // Use green for the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  final cellNumbers = await ApiService.fetchCellNumbers();
                  setState(() {
                    _cellNumbers = cellNumbers;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cell numbers fetched')));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to fetch cell numbers: $e')));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Use green for the button
                padding: const EdgeInsets.all(16.0), // Add padding to the button
              ),
              child: const Text('Fetch Cell Numbers', style: TextStyle(color: Colors.white)), // White text color
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AssignmentPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Use green for the button
                padding: const EdgeInsets.all(16.0), // Add padding to the button
              ),
              child: const Text('Assign Cell Number', style: TextStyle(color: Colors.white)), // White text color
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await ApiService.updateCellNumber(1, '987654321', '2024-08-31', 'Hub1');
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cell number updated')));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update cell number: $e')));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Use green for the button
                padding: const EdgeInsets.all(16.0), // Add padding to the button
              ),
              child: const Text('Update Cell Number', style: TextStyle(color: Colors.white)), // White text color
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _cellNumbers.length,
                itemBuilder: (context, index) {
                  final cellNumber = _cellNumbers[index];
                  return Card(
                    color: Colors.white, // Use white for the card background
                    child: ListTile(
                      title: Text(
                        'Cell Number: ${cellNumber['cell_number']}',
                        style: const TextStyle(color: Colors.black), // Black text color
                      ),
                      subtitle: Text(
                        'Expiry Date: ${cellNumber['expiry_date']} - Hub: ${cellNumber['hub']}',
                        style: const TextStyle(color: Colors.black), // Black text color
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
