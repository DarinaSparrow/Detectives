import 'dart:async';
import 'package:intl/intl.dart';
import 'package:detectives/chatManager.dart';

class gameProcess
{
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

  void runGameLoop(dynamic message) {
    while (countOfOpenedMessages < conversationManager.messages.length)
    {
      countOfOpenedMessages++;

      DateTime now = DateTime.now();
      conversationManager.messages[countOfOpenedMessages - 1].time = DateFormat('HH:mm').format(now);

      if (countOfOpenedMessages < conversationManager.messages.length) {
        conversationManager.setIsOnlineById(conversationManager.messages[countOfOpenedMessages + 1].id);
      }

      if (conversationManager.messages[countOfOpenedMessages - 1].id == currentChat) {
        //обновление открытого чата
        //_detailedChatPageState.addMessageToList(conversationManager.messages[countOfOpenedMessages - 1]); }
      //else {
        // меняем последнее отправленное сообщение в списке чатов
        // фильтруем список чатов
        // отправляем уведомление с заголовком conversationManager.messages[countOfOpenedMessages - 1].name // и сообщение по контексту
      //}

      if (conversationManager.messages[countOfOpenedMessages].flag == 1) {
        Timer(Duration(milliseconds: time), () {});
      }
      else if (conversationManager.messages[countOfOpenedMessages].flag == 2) {
        plotDevelopment = false;

        Timer.periodic(const Duration(milliseconds: 100), (timer) {
          if (plotDevelopment) timer.cancel();
        });
      }
    }
  }
}