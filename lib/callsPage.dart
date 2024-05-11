import 'package:flutter/material.dart';
import 'userSettings.dart';

class callsPage extends StatefulWidget {
  const callsPage({Key? key}) : super(key: key);

  @override
  State<callsPage> createState() => _callsPageState();
}

class _callsPageState extends State<callsPage> {
  void addToNumber(String digit) {
    if (userSettings.phoneNumber.length < 9) {
      setState(() {
        userSettings.phoneNumber += digit;
      });
    }
  }

  void removeLastDigit() {
    setState(() {
      if (userSettings.phoneNumber.isNotEmpty) {
        userSettings.phoneNumber = userSettings.phoneNumber.substring(0, userSettings.phoneNumber.length - 1);
      }
    });
  }

  void dialNumber() {
    print("Dialing $userSettings.phoneNumber");
    // Implement your dialing logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              userSettings.phoneNumber,
              style: TextStyle(fontSize: 50),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNumberButton("1"),
                _buildNumberButton("2"),
                _buildNumberButton("3"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNumberButton("4"),
                _buildNumberButton("5"),
                _buildNumberButton("6"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNumberButton("7"),
                _buildNumberButton("8"),
                _buildNumberButton("9"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNumberButton("*"),
                _buildNumberButton("0"),
                _buildNumberButton("#"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(Icons.call, dialNumber),
                _buildActionButton(Icons.arrow_back, () => removeLastDigit()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberButton(String digit) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton(
        onPressed: () => addToNumber(digit),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const CircleBorder()),
          padding: MaterialStateProperty.all(const EdgeInsets.all(35)),
        ),
        child: Text(
          digit,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: icon == Icons.call ? MaterialStateProperty.all(Colors.green) : MaterialStateProperty.all(Colors.red),
          foregroundColor: MaterialStateProperty.all(Colors.white)
        ),
        child: Icon(icon, size: 50),
      ),
    );
  }
}