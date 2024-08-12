import 'package:flutter/material.dart';
import 'home_page.dart';


class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Silux Mobile'),
        backgroundColor: Colors.green, // Use green for the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(color: Colors.green), // Green label text
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green), // Green underline
                ),
              ),
              cursorColor: Colors.green, // Green cursor
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.green), // Green label text
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green), // Green underline
                ),
              ),
              cursorColor: Colors.green, // Green cursor
              obscureText: true,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Perform login logic here
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Use green for the button
                padding: const EdgeInsets.all(16.0), // Add padding to the button
              ),
              child: const Text('Login', style: TextStyle(color: Colors.white)), // White text color
            ),
          ],
        ),
      ),
    );
  }
}
