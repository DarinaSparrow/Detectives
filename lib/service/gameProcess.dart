import 'dart:async';
import 'package:intl/intl.dart';
import '../chat/chatManager.dart';
import 'appService.dart';

class gameProcess {
  static int countOfOpenedMessages = 0;
  static int currentChat = 0;
  static int chatWithOpenAnswers = 0;
  static bool plotDevelopment = true;

  static void changeCurrentChat(int newChatIndex) {
    currentChat = newChatIndex;
  }

  static void changeChatWithOpenAnswers() {
    chatWithOpenAnswers = 0;
  }

  static void runPlot() {
    plotDevelopment = true;
    countOfOpenedMessages ++;
  }

  static Future<void> runGameLoop() async {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (plotDevelopment) {
        if (countOfOpenedMessages == conversationManager.messages.length) {
          countOfOpenedMessages--;
          conversationManager.setIsOnlineById(0);
          timer.cancel();
        } else {
          conversationManager.updateChats(
              conversationManager.messages[countOfOpenedMessages].id,
              conversationManager.messages[countOfOpenedMessages].content,
              conversationManager.messages[countOfOpenedMessages]
                  .message[conversationManager.messages[countOfOpenedMessages]
                  .indexOfAnswer],
              conversationManager.messages[countOfOpenedMessages].time);

          if (currentChat !=
              conversationManager.messages[countOfOpenedMessages].id) {
            if (conversationManager.messages[countOfOpenedMessages].content ==
                1) {
              appService.sendNotification(
                  conversationManager.messages[countOfOpenedMessages].name,
                  conversationManager.messages[countOfOpenedMessages]
                      .message[0]);
            } else {
              appService.sendNotification(
                  conversationManager.messages[countOfOpenedMessages].name,
                  "Изображение");
            }
          }

          if (conversationManager.messages[countOfOpenedMessages].flag == 1) {
            if (countOfOpenedMessages <
                conversationManager.messages.length - 1) {
              DateTime now = DateTime.now();
              conversationManager.messages[countOfOpenedMessages + 1].time =
                  DateFormat('HH:mm').format(now);

              conversationManager.setIsOnlineById(
                  conversationManager.messages[countOfOpenedMessages + 1].id);
            }

            countOfOpenedMessages++;
          }
          else
          if (conversationManager.messages[countOfOpenedMessages].flag == 2) {
            chatWithOpenAnswers = conversationManager.messages[countOfOpenedMessages + 1].id;
            plotDevelopment = false;
          }
          else {
            plotDevelopment = false;
          }
        }
      }
    });
  }
}