import 'package:flutter/material.dart';
import '../calls/callsPage.dart';
import '../chat/chatsPage.dart';
import '../profile/profilePage.dart';
import 'package:detectives/service/soundPlayer.dart';
import 'package:detectives/service/appService.dart';

final List<String> _appBarTitles = ['Звонки', 'Чаты', 'Профиль'];

final List<Widget> _widgetOptions = <Widget>[
  const callsPage(),
  const chatsPage(),
  const profilePage(),
];

class sceletonOfApp extends StatefulWidget {
  const sceletonOfApp({super.key});

  @override
  State<sceletonOfApp> createState() => _sceletonOfAppState();
}

class _sceletonOfAppState
    extends State<sceletonOfApp> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    SoundPlayer.instance.stopSound();
    SoundPlayer.instance.playSound('tap.mp3');
    appService.vibrate();
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    SoundPlayer.disposeInstance();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _appBarTitles[_selectedIndex],
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Звонки'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Чаты'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
        backgroundColor: Colors.teal,
      ),
    );
  }
}