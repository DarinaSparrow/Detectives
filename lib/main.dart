import 'dart:isolate';
import 'package:detectives/gameProcess.dart';
import 'package:flutter/material.dart';
import 'package:detectives/sceletonOfApp.dart';
import 'package:detectives/chatManager.dart';
import 'package:flutter/services.dart';
import 'dataManager.dart';
import 'appService.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  dataManager.loadSettings();
  appService.initialize();
  conversationManager.initializeConversations();
  conversationManager.initializeMessages();
  conversationManager.initializeProfiles();

  runInIsolate();
  runApp(const App());
}

void runInIsolate() async {
  ReceivePort receivePort = ReceivePort();
  SendPort sendPort = receivePort.sendPort;

  await Isolate.spawn((sendPort) {gameProcess.runGameLoop(sendPort: sendPort);},
      sendPort);
  receivePort.listen((message) {
    print(message);
  });
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const sceletonOfApp(),
    );
  }
}

