import 'package:flutter/material.dart';
import 'callsPage.dart';
import 'chatsPage.dart';
import 'profilePage.dart';

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
    setState(() {
      _selectedIndex = index;
    });
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
            fontSize: 36.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[200],
        toolbarHeight: 100,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Звонки'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Чаты'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[900],
        onTap: _onItemTapped,
        backgroundColor: Colors.blue[200],
      ),
    );
  }
}