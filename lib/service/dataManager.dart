import 'dart:convert';
import 'dart:io';
import '../chat/chatManager.dart';
import '../service/gameProcess.dart';
import 'userSettings.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class dataManager {
  static const String _settingsFilePathAssets = 'assets/data/userSettings.json';
  static late String _settingsFilePathDevice;
  static const String _chatsFilePathAssets = 'assets/data/chats.json';
  static late String _chatsFilePathDevice;
  static const String _messagesFilePathAssets = 'assets/data/messages.json';
  static late String _messagesFilePathDevice;
  static const String _gameProcessFilePathAssets = 'assets/data/gamePlot.json';
  static late String _gameProcessFilePathDevice;
  static const String _profilesFilePathAssets = 'assets/data/profiles.json';

  static Future<void> _initFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    _settingsFilePathDevice = '${directory.path}/userSettings.json';
    _chatsFilePathDevice = '${directory.path}/chats.json';
    _messagesFilePathDevice = '${directory.path}/messages.json';
    _gameProcessFilePathDevice = '${directory.path}/gamePlot.json';
  }

  // Запуск приложения с устройства
  static Future<void> startFromDevice() async {
    await _initFilePath();
    await _loadSettingsFromDevice();
    await _loadConversationsFromDevice();
    await _loadMessagesFromDevice();
    await _loadProfiles();
    await _loadGameProcessFromDevice();
  }

  // Запуск приложения из assets
  static Future<void> startFromAssets() async {
    await _loadSettingsFromAssets();
    await _loadConversationsFromAssets();
    await _loadMessagesFromAssets();
    await _loadProfiles();
    await _loadGameProcessFromAssets();
  }

  // Сброс игрового прогресса
  static Future<void> resetGameProgress() async{
    await _loadConversationsFromAssets();
    await _loadMessagesFromAssets();
  }

  static Future<void> _loadSettingsFromDevice() async {
    try {
      final File file = File(_settingsFilePathDevice);
      if (await file.exists()) {
        final String content = await file.readAsString();
        final Map<String, dynamic> settingsMap = json.decode(content);
        userSettings.fromJson(settingsMap);
      } else {
        await _loadSettingsFromAssets();
      }
    } catch (e) {
      print('Error loading settings from device: $e');
    }
  }

  static Future<void> _loadSettingsFromAssets() async {
    try {
      final jsonString = await _loadJsonFromAssets(_settingsFilePathAssets);
      final Map<String, dynamic> settingsMap = json.decode(jsonString);
      userSettings.fromJson(settingsMap);
      await saveSettings();
    } catch (e) {
      print('Error loading settings from assets: $e');
    }
  }


  static Future<void> _loadConversationsFromDevice() async {
    try {
      final File file = File(_chatsFilePathDevice);
      if (await file.exists()) {
        final String content = await file.readAsString();
        final List<dynamic> conversationsData = json.decode(content);
        conversationManager.conversations = conversationsData.map((data) => Conversation.fromJson(data)).toList();
      } else {
        await _loadConversationsFromAssets();
      }
    } catch (e) {
      print('Error loading conversations from device: $e');
    }
  }

  static Future<void> _loadConversationsFromAssets() async {
    try {
      final jsonString = await _loadJsonFromAssets(_chatsFilePathAssets);
      final List<dynamic> conversationsData = json.decode(jsonString);
      conversationManager.conversations = conversationsData.map((data) => Conversation.fromJson(data)).toList();
      await saveConversations();
    } catch (e) {
      print('Error loading conversations from assets: $e');
    }
  }

  static Future<void> _loadMessagesFromDevice() async {
    try {
      final File file = File(_messagesFilePathDevice);
      if (await file.exists()) {
        final String content = await file.readAsString();
        final List<dynamic> messagesData = json.decode(content);
        conversationManager.messages = messagesData.map((data) => Message.fromJson(data)).toList();
      } else {
        await _loadMessagesFromAssets();
      }
    } catch (e) {
      print('Error loading messages from device: $e');
    }
  }

  static Future<void> _loadMessagesFromAssets() async {
    try {
      final jsonString = await _loadJsonFromAssets(_messagesFilePathAssets);
      final List<dynamic> messagesData = json.decode(jsonString);
      conversationManager.messages = messagesData.map((data) => Message.fromJson(data)).toList();
      await saveMessages();
    } catch (e) {
      print('Error loading messages from assets: $e');
    }
  }

  static Future<void> _loadProfiles() async {
    try {
      final jsonString = await _loadJsonFromAssets(_profilesFilePathAssets);
      final List<dynamic> profilesData = json.decode(jsonString);
      conversationManager.profiles = profilesData.map((data) => Profile.fromJson(data)).toList();
    } catch (e) {
      print('Error loading profiles: $e');
    }
  }

  static Future<void> _loadGameProcessFromDevice() async {
    try {
      final File file = File(_gameProcessFilePathDevice);
      if (await file.exists()) {
        final String content = await file.readAsString();
        final Map<String, dynamic> gameProcessMap = json.decode(content);
        gameProcess.fromJson(gameProcessMap);
      } else {
        await _loadGameProcessFromAssets();
      }
    } catch (e) {
      print('Error loading game process from device: $e');
    }
  }

  static Future<void> _loadGameProcessFromAssets() async {
    try {
      final jsonString = await _loadJsonFromAssets(_gameProcessFilePathAssets);
      final Map<String, dynamic> gameProcessMap = json.decode(jsonString);
      gameProcess.fromJson(gameProcessMap);
      await saveGameProcess();
    } catch (e) {
      print('Error loading game process from assets: $e');
    }
  }

  static Future<void> saveSettings() async {
    try {
      await _initFilePath();
      final Map<String, dynamic> settingsMap = userSettings.toJson();
      final String jsonString = json.encode(settingsMap);
      final File file = File(_settingsFilePathDevice);
      await file.writeAsString(jsonString);
    } catch (e) {
      print('Error saving settings: $e');
    }
  }

  static Future<void> saveConversations() async {
    try {
      await _initFilePath();
      final List<Map<String, dynamic>> conversationsData = conversationManager.conversations.map((conversation) => conversation.toJson()).toList();
      final String jsonString = json.encode(conversationsData);
      final File file = File(_chatsFilePathDevice);
      await file.writeAsString(jsonString);
    } catch (e) {
      print('Error saving conversations: $e');
    }
  }

  static Future<void> saveMessages() async {
    try {
      await _initFilePath();
      final List<Map<String, dynamic>> messagesData = conversationManager.messages.map((message) => message.toJson()).toList();
      final String jsonString = json.encode(messagesData);
      final File file = File(_messagesFilePathDevice);
      await file.writeAsString(jsonString);
    } catch (e) {
      print('Error saving messages: $e');
    }
  }

  static Future<void> saveGameProcess() async {
    try {
      await _initFilePath();
      final Map<String, dynamic> gameProcessMap = gameProcess.toJson();
      final String jsonString = json.encode(gameProcessMap);
      final File file = File(_gameProcessFilePathDevice);
      await file.writeAsString(jsonString);
    } catch (e) {
      print('Error saving game process: $e');
    }
  }

  static Future<String> _loadJsonFromAssets(String path) async {
    final jsonString = await rootBundle.loadString(path);
    return jsonString;
  }
}