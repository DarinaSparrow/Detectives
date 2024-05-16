import 'dart:async';
import 'package:detectives/service/userSettings.dart';
import 'package:intl/intl.dart';
import '../chat/chatManager.dart';
import 'appService.dart';

class gameProcess {
  static int countOfOpenedMessages = 0;
  static int currentChat = 0;
  static int chatWithOpenAnswers = 0;
  static bool plotDevelopment = true;
  static bool stop = true;
  static int duration = 3;
  static bool resetTimer = false;

  static fromJson(Map<String, dynamic> json) {
    countOfOpenedMessages = json['countOfOpenedMessages'];
    currentChat = json['currentChat'];
    chatWithOpenAnswers = json['chatWithOpenAnswers'];
    plotDevelopment = json['plotDevelopment'];
    stop = json['stop'];
    duration = json['duration'];
    resetTimer = json['resetTimer'];
  }

  static Map<String, dynamic> toJson() {
    return {
      'countOfOpenedMessages': countOfOpenedMessages,
      'currentChat': currentChat,
      'chatWithOpenAnswers': chatWithOpenAnswers,
      'plotDevelopment': plotDevelopment,
      'stop': stop,
      'duration': duration,
      'resetTimer': resetTimer,
    };
  }

  static void updateDuration(){
    switch(userSettings.selectedSpeed){
      case 1:
        gameProcess.duration = 6;
        break;
      case 2:
        gameProcess.duration = 3;
        break;
      case 3:
        gameProcess.duration = 1;
        break;
    }
    resetTimer = true;
  }

  static void changeCurrentChat(int newChatIndex) {
    currentChat = newChatIndex;
  }

  static void changeChatWithOpenAnswers() {
    chatWithOpenAnswers = 0;
  }

  static void runPlot() {
    plotDevelopment = true;
  }

  static Future<void> runGameLoop() async {
    Timer.periodic(Duration(seconds: duration), (timer) {
      if (plotDevelopment) {
        if (countOfOpenedMessages == conversationManager.messages.length) {
          countOfOpenedMessages--;
          conversationManager.setIsOnlineById(0);
          timer.cancel();
        } else {
          if (countOfOpenedMessages != 0) countOfOpenedMessages++;

          DateTime now = DateTime.now();
          conversationManager.messages[countOfOpenedMessages + 1].time =
              DateFormat('HH:mm').format(now);

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
            if (countOfOpenedMessages < conversationManager.messages.length - 1) {
              conversationManager.setIsOnlineById(
                  conversationManager.messages[countOfOpenedMessages + 1].id);
            }

            if (countOfOpenedMessages == 0) countOfOpenedMessages++;
          }
          else
          if (conversationManager.messages[countOfOpenedMessages].flag == 2) {
            chatWithOpenAnswers = conversationManager.messages[countOfOpenedMessages].id;
            plotDevelopment = false;
          }
          else {
            plotDevelopment = false;
          }
        }
      }
      if (resetTimer){
        resetTimer = false;
        timer.cancel();
        runGameLoop();
      }
    });
  }

  static void restart() {
    countOfOpenedMessages = 0;
    currentChat = 0;
    chatWithOpenAnswers = 0;
    plotDevelopment = true;
    stop = true;
    duration = 3;
    resetTimer = false;
  }
}