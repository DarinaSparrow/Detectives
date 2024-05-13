import 'dart:async';
import 'dart:isolate';
import 'package:intl/intl.dart';
import 'package:detectives/chatManager.dart';

class gameProcess {
  static int countOfOpenedMessages = 5;
  static int currentChat = -1;
  static int time = 3000;
  static bool plotDevelopment = true;

  static void changeCurrentChat(int newChatIndex) {
    currentChat = newChatIndex;
  }

  static void changeTime(int newTime) {
    time = newTime;
  }

  static void changePlotDevelopment() {
    plotDevelopment = true;
  }

  static Future<void> runGameLoop({required SendPort sendPort}) async {
    try {
      while (countOfOpenedMessages < conversationManager.messages.length) {
        countOfOpenedMessages++;

        DateTime now = DateTime.now();
        conversationManager.messages[countOfOpenedMessages - 1].time =
            DateFormat('HH:mm').format(now);

        if (countOfOpenedMessages < conversationManager.messages.length) {
          conversationManager.setIsOnlineById(
              conversationManager.messages[countOfOpenedMessages + 1].id);
        }

        if (conversationManager.messages[countOfOpenedMessages - 1].id ==
            currentChat) {
          // Update the open chat
          // _detailedChatPageState.addMessageToList(conversationManager.messages[countOfOpenedMessages - 1]);

          if (conversationManager.messages[countOfOpenedMessages].flag == 1) {
            await Future.delayed(Duration(milliseconds: time));
          } else if (conversationManager.messages[countOfOpenedMessages].flag == 2) {
            plotDevelopment = false;

            await Future.doWhile(() async {
              await Future.delayed(Duration(milliseconds: 100));
              return plotDevelopment;
            });
          }
        }
      }
    } catch (e, stackTrace) {
      sendPort.send("Error: $e, Stack trace: $stackTrace");
    }
  }
}