class Conversation {
  int id;
  int type;
  String image;
  String name;
  String lastMessage;
  String time;
  bool isMessageRead;
  bool isOnline;
  int countOfOpenedMessages;

  Conversation({required this.id, required this.type, required this.image, required this.name, required this.lastMessage, required this.time, required this.isMessageRead, required this.isOnline, required this.countOfOpenedMessages});
}

class Message {
  int id;
  int status;
  String image;
  String name;
  int content;
  String message;
  String time;
  int flag;
  List<String> answers;
  int indexOfAnswer;
  bool display;

  Message({required this.id, required this.status, required this.image, required this.name, required this.content, required this.message, required this.time, required this.flag, required this.answers, required this.indexOfAnswer, required this.display});
}

class conversationManager
{
  static List<Conversation> conversations = [];
  static List<Message> messages = [];

  static void initializeConversations() {
    conversations = [
      Conversation(id: 1, type: 1, image: 'assets/group.png', name: "Неуловимые мстители", lastMessage: "Привет!", time: "12:50", isMessageRead: false, isOnline: true, countOfOpenedMessages: 0),
      Conversation(id: 2, type: 2, image: 'assets/Женя.jpg', name: "Кейт Бланшет", lastMessage: "Привет!", time: "13:40", isMessageRead: true, isOnline: true, countOfOpenedMessages: 0),
      Conversation(id: 3, type: 2, image: 'assets/Дарина.jpg', name: "Хелена Боннем Картер", lastMessage: "Привет!", time: "12:52", isMessageRead: false, isOnline: false, countOfOpenedMessages: 0),
    ];
  }

  static void initializeMessages() {
    messages = [
      Message(id: 1, status: 1, image: 'assets/Женя.jpg', name: "Кейт Бланшет", content: 3, message: "assets/Женя.jpg", time: "12:52", flag: 1, answers: [], indexOfAnswer: -1, display: true),
      Message(id: 1, status: 2, image: 'assets/Женя.jpg', name: "кто-то", content: 1, message: "Лохи", time: "12:52", flag: 1, answers: [], indexOfAnswer: -1, display: true),
      Message(id: 1, status: 1, image: 'assets/Женя.jpg', name: "Хелена Боннем Картер", content: 1, message: "Лохи", time: "12:52", flag: 1, answers: [], indexOfAnswer: -1, display: true),
      Message(id: 1, status: 1, image: 'assets/Женя.jpg', name: "Кейт Бланшет", content: 1, message: "Лохи", time: "12:52", flag: 1, answers: [], indexOfAnswer: -1, display: true),
      Message(id: 1, status: 2, image: 'assets/Женя.jpg', name: "кто-то", content: 1, message: "Лохи", time: "12:52", flag: 1, answers: [], indexOfAnswer: -1, display: true),
      Message(id: 1, status: 1, image: 'assets/Женя.jpg', name: "Хелена Боннем Картер", content: 1, message: "Лохи", time: "12:52", flag: 1, answers: [], indexOfAnswer: -1, display: true),
      Message(id: 2, status: 1, image: 'assets/Женя.jpg', name: "Кейт Бланшет", content: 1, message: "Лохи", time: "12:52", flag: 1, answers: [], indexOfAnswer: -1, display: true),
      Message(id: 2, status: 2, image: 'assets/Женя.jpg', name: "кто-то", content: 1, message: "Лохи", time: "12:52", flag: 1, answers: [], indexOfAnswer: -1, display: true),
      Message(id: 2, status: 1, image: 'assets/Женя.jpg', name: "Кейт Бланшет", content: 1, message: "Лохи", time: "12:52", flag: 1, answers: [], indexOfAnswer: -1, display: true),
      Message(id: 2, status: 2, image: 'assets/Женя.jpg', name: "кто-то", content: 1, message: "Лохи", time: "12:52", flag: 1, answers: [], indexOfAnswer: -1, display: true),
      Message(id: 3, status: 1, image: 'assets/Женя.jpg', name: "Кейт Бланшет", content: 1, message: "Лохи", time: "12:52", flag: 1, answers: [], indexOfAnswer: -1, display: true),
      Message(id: 3, status: 2, image: 'assets/Женя.jpg', name: "кто-то", content: 3, message: "assets/Женя.jpeg", time: "12:52", flag: 1, answers: [], indexOfAnswer: -1, display: true),
      Message(id: 3, status: 1, image: 'assets/Женя.jpg', name: "Кейт Бланшет", content: 1, message: "Лохи", time: "12:52", flag: 1, answers: [], indexOfAnswer: -1, display: true),
      Message(id: 3, status: 2, image: 'assets/Женя.jpg', name: "кто-то", content: 1, message: "Лохи", time: "12:52", flag: 1, answers: [], indexOfAnswer: -1, display: true),
    ];
  }

  static int getTypeById(int id) {
    Conversation? conversation = conversations.firstWhere((
        conversation) => conversation.id == id);
    return conversation.type;
  }

  static String getImageById(int id) {
    Conversation? conversation = conversations.firstWhere((conversation) => conversation.id == id);
    return conversation.image;
  }

  static String getNameById(int id) {
    Conversation? conversation = conversations.firstWhere((conversation) => conversation.id == id);
    return conversation.name;
  }

  static bool getIsOnlineById(int id) {
    Conversation? conversation = conversations.firstWhere((conversation) => conversation.id == id);
    return conversation.isOnline;
  }

  static void setIsOnlineById(int id) {
    for(var conversation in conversationManager.conversations) {
      if (conversation.id == id) {
        conversation.isOnline = true;
      }
      else {
        conversation.isOnline = false;
      }
    }
  }
}