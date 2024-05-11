class Conversation {
  int id;
  int type;
  String image;
  String name;
  String lastMessage;
  String time;
  bool isMessageRead;
  bool isOnline;

  Conversation({required this.id, required this.type, required this.image, required this.name, required this.lastMessage, required this.time, required this.isMessageRead, required this.isOnline});
}

class Message {
  int id;
  int status;
  String image;
  String name;
  int content;
  String message;
  String time;

  Message({required this.id, required this.status, required this.image, required this.name, required this.content, required this.message, required this.time});
}

class conversationManager
{
  static List<Conversation> conversations = [];
  static List<Message> messages = [];

  static void initializeConversations() {
    conversations = [
      Conversation(id: 1, type: 1, image: 'assets/group.png', name: "Неуловимые мстители", lastMessage: "Привет!", time: "12:50", isMessageRead: false, isOnline: true),
      Conversation(id: 2, type: 2, image: 'assets/12345.jpg', name: "Кейт Бланшет", lastMessage: "Привет!", time: "13:40", isMessageRead: true, isOnline: true),
      Conversation(id: 3, type: 2, image: 'assets/54321.jpeg', name: "Хелена Боннем Картер", lastMessage: "Привет!", time: "12:52", isMessageRead: false, isOnline: false),
    ];
  }

  static void initializeMessages() {
    messages = [
      Message(id: 1, status: 1, image: 'assets/12345.jpg', name: "Кейт Бланшет", content: 1, message: "Лохи", time: "12:52"),
      Message(id: 1, status: 2, image: 'assets/12345.jpg', name: "кто-то", content: 1, message: "Лохи", time: "12:52"),
      Message(id: 1, status: 1, image: 'assets/54321.jpeg', name: "Хелена Боннем Картер", content: 1, message: "Лохи", time: "12:52"),
      Message(id: 1, status: 1, image: 'assets/12345.jpg', name: "Кейт Бланшет", content: 1, message: "Лохи", time: "12:52"),
      Message(id: 1, status: 2, image: 'assets/12345.jpg', name: "кто-то", content: 1, message: "Лохи", time: "12:52"),
      Message(id: 1, status: 1, image: 'assets/54321.jpeg', name: "Хелена Боннем Картер", content: 1, message: "Лохи", time: "12:52"),
      Message(id: 2, status: 1, image: 'assets/12345.jpg', name: "Кейт Бланшет", content: 1, message: "Лохи", time: "12:52"),
      Message(id: 2, status: 2, image: 'assets/12345.jpg', name: "кто-то", content: 1, message: "Лохи", time: "12:52"),
      Message(id: 2, status: 1, image: 'assets/12345.jpg', name: "Кейт Бланшет", content: 1, message: "Лохи", time: "12:52"),
      Message(id: 2, status: 2, image: 'assets/12345.jpg', name: "кто-то", content: 1, message: "Лохи", time: "12:52"),
      Message(id: 3, status: 1, image: 'assets/12345.jpg', name: "Кейт Бланшет", content: 1, message: "Лохи", time: "12:52"),
      Message(id: 3, status: 2, image: 'assets/12345.jpg', name: "кто-то", content: 1, message: "Лохи", time: "12:52"),
      Message(id: 3, status: 1, image: 'assets/12345.jpg', name: "Кейт Бланшет", content: 1, message: "Лохи", time: "12:52"),
      Message(id: 3, status: 2, image: 'assets/12345.jpg', name: "кто-то", content: 1, message: "Лохи", time: "12:52"),
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
}