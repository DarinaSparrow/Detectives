import 'package:flutter/material.dart';
import 'userSettings.dart';

class callsPage extends StatefulWidget {
  const callsPage({super.key});

  @override
  State<callsPage> createState() => _callsPageState();
}

class _callsPageState extends State<callsPage> {
  Map<String, List<String>> letterMap = {
    '1': [' ', ' ', ' ', ' '],
    '2': ['A', 'B', 'C'],
    '3': ['D', 'E', 'F'],
    '4': ['G', 'H', 'I'],
    '5': ['J', 'K', 'L'],
    '6': ['M', 'N', 'O'],
    '7': ['P', 'Q', 'R', 'S'],
    '8': ['T', 'U', 'V'],
    '9': ['W', 'X', 'Y', 'Z'],
    '0': ['+'],
    '*': [' ', ' ', ' ', ' '],
    '#': [' ', ' ', ' ', ' '],
  };

  void addToNumber(String digit) {
    if (userSettings.phoneNumber.length < 11) {
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const lastCallPage()),
    );
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
              style: const TextStyle(fontSize: 50),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _dialerButton(number: '1', letters: letterMap['1'] ?? []),
                _dialerButton(number: '2', letters: letterMap['2'] ?? []),
                _dialerButton(number: '3', letters: letterMap['3'] ?? []),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _dialerButton(number: '4', letters: letterMap['4'] ?? []),
                _dialerButton(number: '5', letters: letterMap['5'] ?? []),
                _dialerButton(number: '6', letters: letterMap['6'] ?? []),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _dialerButton(number: '7', letters: letterMap['7'] ?? []),
                _dialerButton(number: '8', letters: letterMap['8'] ?? []),
                _dialerButton(number: '9', letters: letterMap['9'] ?? []),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _dialerSingleButton(number: '*'),
                _dialerButton(number: '0', letters: letterMap['0'] ?? []),
                _dialerSingleButton(number: '#'),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _voidButton(),
                _actionButton(icon: Icons.call, onPressed: dialNumber),
                if (userSettings.phoneNumber.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextButton(
                      onPressed: removeLastDigit,
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(const CircleBorder()),
                        minimumSize: MaterialStateProperty.all(const Size.fromRadius(35.0)),
                      ),
                      child: const Icon(
                        Icons.backspace_outlined,
                        size: 25,
                      ),
                    ),
                  ),
                if(userSettings.phoneNumber.isEmpty)
                  _voidButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _voidButton() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 70,
        width: 70,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _dialerButton({required String number, required List<String> letters}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: OutlinedButton(
        onPressed: () => addToNumber(number),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const CircleBorder()),
          minimumSize: MaterialStateProperty.all(const Size.fromRadius(35.0)),
          //padding: MaterialStateProperty.all(const EdgeInsets.all(30))),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              number,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            if (letters.isNotEmpty)
              Text(
                letters.join(),
                style: const TextStyle(
                  fontSize: 7.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _dialerSingleButton({required String number}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: OutlinedButton(
        onPressed: () => addToNumber(number),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const CircleBorder()),
          minimumSize: MaterialStateProperty.all(const Size.fromRadius(35.0)),
          //padding: MaterialStateProperty.all(const EdgeInsets.all(30))),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              number,
              style: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton({required IconData icon, required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const CircleBorder()),
          minimumSize: MaterialStateProperty.all(const Size.fromRadius(35.0)),
          backgroundColor: MaterialStateProperty.all(Colors.green),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 25,
            ),
          ],
        ),
      ),
    );
  }
}

class lastCallPage extends StatelessWidget {
  const lastCallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              userSettings.phoneNumber,
              style: const TextStyle(
                fontSize: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _interactionButton(
                    icon: Icons.add, label: 'Доб. вызов'),
                _interactionButton(
                    icon: Icons.video_call, label: 'Видеовызов'),
                _interactionButton(
                    icon: Icons.bluetooth, label: 'Bluetooth'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _interactionButton(
                    icon: Icons.volume_up_outlined, label: 'Динамик'),
                _interactionButton(
                    icon: Icons.mic_off, label: 'Откл. микр.'),
                _interactionButton(
                    icon: Icons.keyboard_alt_outlined, label: 'Клавиатура'),
              ],
            ),
            const SizedBox(height: 70,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _actionButton(icon: Icons.call_end, onPressed: () {
                  Navigator.pop(context);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _interactionButton({required IconData icon, required String label}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton(
            onPressed: null,
            style: ButtonStyle(
              shape: MaterialStateProperty.all(const CircleBorder()),
              minimumSize: MaterialStateProperty.all(
                  const Size.fromRadius(35.0)),
              backgroundColor: MaterialStateProperty.all(Colors.grey[600]),
              foregroundColor: MaterialStateProperty.all(Colors.white),
            ),
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(
      {required IconData icon, required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const CircleBorder()),
          minimumSize: MaterialStateProperty.all(const Size.fromRadius(35.0)),
          backgroundColor: MaterialStateProperty.all(Colors.red),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 35,
            ),
          ],
        ),
      ),
    );
  }
}
