import 'package:detectives/service/appService.dart';
import 'package:detectives/service/userSettings.dart';
import 'package:flutter/material.dart';
import 'package:detectives/service/soundPlayer.dart';
import 'package:detectives/service/gameProcess.dart';

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
    SoundPlayer.instance.stopSound();
    SoundPlayer.instance.playSound('dialing.mp3');
    appService.vibrate();
    if (userSettings.phoneNumber.length < 11) {
      setState(() {

        userSettings.phoneNumber += digit;
      });
    }
  }

  void removeLastDigit() {
    SoundPlayer.instance.stopSound();
    SoundPlayer.instance.playSound('tap.mp3');
    appService.vibrate();
    setState(() {
      if (userSettings.phoneNumber.isNotEmpty) {
        userSettings.phoneNumber = userSettings.phoneNumber.substring(0, userSettings.phoneNumber.length - 1);
      }
    });
  }

  void dialNumber() {
    appService.vibrate();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const lastCallPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/backgroundforcallsandprofile.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userSettings.phoneNumber,
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.11),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.05),
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
                SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _voidButton(),
                    _actionButton(icon: Icons.call, onPressed: dialNumber),
                    if (userSettings.phoneNumber.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
                        child: TextButton(
                          onPressed: removeLastDigit,
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(const CircleBorder()),
                            minimumSize: MaterialStateProperty.all(Size.fromRadius(MediaQuery.of(context).size.width * 0.09)),
                          ),
                          child: Icon(
                            Icons.backspace_outlined,
                            color: Colors.teal.shade900,
                            size: MediaQuery.of(context).size.width * 0.08,
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
        )
    );
  }

  Widget _voidButton() {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
      child: Container(
        height: MediaQuery.of(context).size.width * 0.18,
        width: MediaQuery.of(context).size.width * 0.18,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _dialerButton({required String number, required List<String> letters}) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
      child: ElevatedButton(
        onPressed: () => addToNumber(number),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const CircleBorder()),
          minimumSize: MaterialStateProperty.all(Size.fromRadius(MediaQuery.of(context).size.width * 0.09)),
          side: MaterialStateProperty.all(
              BorderSide(
                color: Colors.teal.shade900,
              )
          ),
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              number,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.07,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            if (letters.isNotEmpty)
              Text(
                letters.join(),
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.02,
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
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
      child: OutlinedButton(
        onPressed: () => addToNumber(number),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const CircleBorder()),
          minimumSize: MaterialStateProperty.all(Size.fromRadius(MediaQuery.of(context).size.width * 0.09)),
          side: MaterialStateProperty.all(
              BorderSide(
                color: Colors.teal.shade900,
              )
          ),
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              number,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.08,
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
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const CircleBorder()),
          minimumSize: MaterialStateProperty.all(Size.fromRadius(MediaQuery.of(context).size.width * 0.09)),
          backgroundColor: MaterialStateProperty.all(Colors.tealAccent.shade700),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          side: MaterialStateProperty.all(
              BorderSide(
                color: Colors.teal.shade900,
              )
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: MediaQuery.of(context).size.width * 0.09,
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
    if (userSettings.phoneNumber == '89996665544' && gameProcess.countOfOpenedMessages >= 5) {
      SoundPlayer.instance.playSound('rickroll.mp3', onCompletion: () {
        Navigator.pop(context);
        if (gameProcess.countOfOpenedMessages == 5) {
          gameProcess.runPlot();
        }
      });

    }
    else {
      SoundPlayer.instance.playSound('beeps.mp3', loop: true);
    }

    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              userSettings.phoneNumber,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.11,
                color: Colors.white,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _interactionButton( context,
                    icon: Icons.add, label: 'Доб. вызов'),
                _interactionButton( context,
                    icon: Icons.video_call, label: 'Видеовызов'),
                _interactionButton( context,
                    icon: Icons.bluetooth, label: 'Bluetooth'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _interactionButton( context,
                    icon: Icons.volume_up_outlined, label: 'Динамик'),
                _interactionButton( context,
                    icon: Icons.mic_off, label: 'Откл. микр.'),
                _interactionButton( context,
                    icon: Icons.keyboard_alt_outlined, label: 'Клавиатура'),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _actionButton(context, icon: Icons.call_end, onPressed: () {
                  appService.vibrate();
                  SoundPlayer.instance.stopSound();
                  Navigator.pop(context);
                  if (userSettings.phoneNumber == '89996665544' && gameProcess.countOfOpenedMessages == 5) {
                    gameProcess.runPlot();
                  }
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _interactionButton(BuildContext context, {required IconData icon, required String label}) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton(
            onPressed: () {appService.vibrate();},
            style: ButtonStyle(
              shape: MaterialStateProperty.all(const CircleBorder()),
              minimumSize: MaterialStateProperty.all(Size.fromRadius(MediaQuery.of(context).size.width * 0.09)),
              backgroundColor: MaterialStateProperty.all(Colors.grey[600]),
              foregroundColor: MaterialStateProperty.all(Colors.white),
            ),
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
                size: MediaQuery.of(context).size.width * 0.09,
              ),
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width * 0.03,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(BuildContext context, {required IconData icon, required VoidCallback onPressed}) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const CircleBorder()),
          minimumSize: MaterialStateProperty.all(Size.fromRadius(MediaQuery.of(context).size.width * 0.09)),
          backgroundColor: MaterialStateProperty.all(Colors.red),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: MediaQuery.of(context).size.width * 0.09,
            ),
          ],
        ),
      ),
    );
  }
}
