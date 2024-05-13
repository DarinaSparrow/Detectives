import 'dart:async';
import 'package:detectives/chatManager.dart';
import 'chatsPage.dart';

class gameProcess {
  static int countOfOpenedMessages = 0;
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

  static Future<void> runGameLoop() async {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (countOfOpenedMessages == conversationManager.messages.length - 1) {
        timer.cancel();
      }

      print("new message $countOfOpenedMessages");

      // DateTime now = DateTime.now();
      // conversationManager.messages[countOfOpenedMessages - 1].time =
      //     DateFormat('HH:mm').format(now);
      //
      // if (countOfOpenedMessages < conversationManager.messages.length) {
      //   conversationManager.setIsOnlineById(
      //       conversationManager.messages[countOfOpenedMessages + 1].id);
      // }
      //
      // if (conversationManager.messages[countOfOpenedMessages - 1].id ==
      //     currentChat) {
      //   // Update the open chat
      //   print("new message");
      //   //_detailedChatPageState.addMessageToList(conversationManager.messages[countOfOpenedMessages - 1]);
      //
      //   if (conversationManager.messages[countOfOpenedMessages].flag == 1) {
      //     Future.delayed(Duration(milliseconds: time));
      //   } else if (conversationManager.messages[countOfOpenedMessages].flag == 2) {
      //     plotDevelopment = false;
      //
      //     Future.doWhile(() async {
      //       await Future.delayed(const Duration(milliseconds: 100));
      //       return plotDevelopment;
      //     });
      //   }
      // }

      countOfOpenedMessages++;
    });
  }
}