import 'package:flutter/material.dart';
import 'package:cell_number_app/services/api_service.dart';


// ignore: must_be_immutable
class AssignmentPage extends StatelessWidget {
  final TextEditingController _cellNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final List<String> _hubs = ['Hub1', 'Hub2', 'Hub3']; // Replace with dynamic data from DB
  String? _selectedHub;

  AssignmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assign Cell Number'),
        backgroundColor: Colors.green, // Use green for the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              items: _hubs.map((hub) {
                return DropdownMenuItem(
                  value: hub,
                  child: Text(hub, style: const TextStyle(color: Colors.black)), // Black text color
                );
              }).toList(),
              onChanged: (value) {
                _selectedHub = value;
              },
              decoration: const InputDecoration(
                labelText: 'Hub',
                labelStyle: TextStyle(color: Colors.green), // Green label text
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green), // Green underline
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _cellNumberController,
              decoration: const InputDecoration(
                labelText: 'Cell Number',
                labelStyle: TextStyle(color: Colors.green), // Green label text
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green), // Green underline
                ),
              ),
              cursorColor: Colors.green, // Green cursor
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _expiryDateController,
              decoration: const InputDecoration(
                labelText: 'Expiry Date (YYYY-MM-DD)',
                labelStyle: TextStyle(color: Colors.green), // Green label text
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green), // Green underline
                ),
              ),
              cursorColor: Colors.green, // Green cursor
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                final cellNumber = _cellNumberController.text;
                final expiryDate = _expiryDateController.text;
                final hub = _selectedHub;

                if (cellNumber.isNotEmpty && expiryDate.isNotEmpty && hub != null) {
                  await ApiService.assignCellNumber(cellNumber, expiryDate, hub);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cell number assigned')));
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Use green for the button
                padding: const EdgeInsets.all(16.0), // Add padding to the button
              ),
              child: const Text('Assign', style: TextStyle(color: Colors.white)), // White text color
            ),
          ],
        ),
      ),
    );
  }
}
