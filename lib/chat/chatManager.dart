import 'package:intl/intl.dart';
import '../service/gameProcess.dart';

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

  Conversation({
    required this.id,
    required this.type,
    required this.image,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.isMessageRead,
    required this.isOnline,
    required this.countOfOpenedMessages,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'],
      type: json['type'],
      image: json['image'],
      name: json['name'],
      lastMessage: json['lastMessage'],
      time: json['time'],
      isMessageRead: json['isMessageRead'],
      isOnline: json['isOnline'],
      countOfOpenedMessages: json['countOfOpenedMessages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'image': image,
      'name': name,
      'lastMessage': lastMessage,
      'time': time,
      'isMessageRead': isMessageRead,
      'isOnline': isOnline,
      'countOfOpenedMessages': countOfOpenedMessages,
    };
  }
}

class Message {
  int id;
  int status;
  String image;
  String name;
  int content;
  List<String> message;
  String time;
  int flag;
  List<String> answers;
  int indexOfAnswer;
  bool display;

  Message({
    required this.id,
    required this.status,
    required this.image,
    required this.name,
    required this.content,
    required this.message,
    required this.time,
    required this.flag,
    required this.answers,
    required this.indexOfAnswer,
    required this.display,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      status: json['status'],
      image: json['image'],
      name: json['name'],
      content: json['content'],
      message: List<String>.from(json['message']),
      time: json['time'],
      flag: json['flag'],
      answers: List<String>.from(json['answers']),
      indexOfAnswer: json['indexOfAnswer'],
      display: json['display'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'image': image,
      'name': name,
      'content': content,
      'message': message,
      'time': time,
      'flag': flag,
      'answers': answers,
      'indexOfAnswer': indexOfAnswer,
      'display': display,
    };
  }
}

class Profile {
  String image;
  String name;
  String status;
  String firstLink;
  String secondLink;
  String thirdLink;

  Profile({
    required this.image,
    required this.name,
    required this.status,
    required this.firstLink,
    required this.secondLink,
    required this.thirdLink,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      image: json['image'],
      name: json['name'],
      status: json['status'],
      firstLink: json['firstLink'],
      secondLink: json['secondLink'],
      thirdLink: json['thirdLink'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'status': status,
      'firstLink': firstLink,
      'secondLink': secondLink,
      'thirdLink': thirdLink,
    };
  }
}

class conversationManager
{
  static List<Conversation> conversations = [];
  static List<Message> messages = [];
  static List<Profile> profiles = [];

  static Future<void> initializeConversations() async {
    await Future.delayed(const Duration(milliseconds: 10));
    conversations = [
      Conversation(id: 1, type: 1, image: 'assets/group.png', name: "Неуловимые мстители", lastMessage: " ", time: " ", isMessageRead: false, isOnline: true, countOfOpenedMessages: 0),
      Conversation(id: 2, type: 2, image: 'assets/Чайлдфри.jpg', name: "Кейт Бланшет", lastMessage: " ", time: " ", isMessageRead: true, isOnline: true, countOfOpenedMessages: 3),
      Conversation(id: 3, type: 2, image: 'assets/Дарина.jpg', name: "Хелена Боннем Картер", lastMessage: " ", time: " ", isMessageRead: false, isOnline: false, countOfOpenedMessages: 5),
    ];
  }

  static Future<void> initializeMessages() async {
    await Future.delayed(const Duration(milliseconds: 10));
    messages = [
      Message(id: 1, status: 3, image: 'assets/Женя.jpg', name: "Кейт Бланшет", content: 1, message: ["0"], time: " ", flag: 1, answers: [], indexOfAnswer: 0, display: true),
      Message(id: 1, status: 1, image: 'assets/Женя.jpg', name: "Кейт Бланшет", content: 1, message: ["1"], time: "---", flag: 1, answers: [], indexOfAnswer: 0, display: true),
      Message(id: 1, status: 1, image: 'assets/Женя.jpg', name: "кто-то", content: 1, message: ["2"], time: "---", flag: 1, answers: [], indexOfAnswer: 0, display: true),
      Message(id: 1, status: 1, image: 'assets/Женя.jpg', name: "Хелена Боннем Картер", content: 1, message: ["3"], time: "---", flag: 1, answers: [], indexOfAnswer: 0, display: true),
      Message(id: 1, status: 1, image: 'assets/Женя.jpg', name: "Кейт Бланшет", content: 1, message: ["4"], time: "---", flag: 2, answers: ["123", "456", "789"], indexOfAnswer: 0, display: true),
      Message(id: 1, status: 1, image: 'assets/Женя.jpg', name: "кто-то", content: 1, message: ["5"], time: "---", flag: 1, answers: [], indexOfAnswer: 0, display: true),
      Message(id: 1, status: 1, image: 'assets/Женя.jpg', name: "Кейт Бланшет", content: 1, message: ["6"], time: "---", flag: 1, answers: [], indexOfAnswer: 0, display: true),
      Message(id: 1, status: 1, image: 'assets/Женя.jpg', name: "кто-то", content: 1, message: ["7"], time: "---", flag: 1, answers: [], indexOfAnswer: 0, display: true),
      Message(id: 1, status: 1, image: 'assets/Женя.jpg', name: "Хелена Боннем Картер", content: 1, message: ["8"], time: "---", flag: 1, answers: [], indexOfAnswer: 0, display: true),
      Message(id: 1, status: 1, image: 'assets/Женя.jpg', name: "Кейт Бланшет", content: 1, message: ["9"], time: "---", flag: 1, answers: [], indexOfAnswer: 0, display: true),
      Message(id: 1, status: 1, image: 'assets/Женя.jpg', name: "кто-то", content: 1, message: ["10"], time: "---", flag: 1, answers: [], indexOfAnswer: 0, display: true),
      Message(id: 1, status: 1, image: 'assets/Женя.jpg', name: "Кейт Бланшет", content: 1, message: ["11"], time: "---", flag: 1, answers: [], indexOfAnswer: 0, display: true),
      Message(id: 1, status: 1, image: 'assets/Женя.jpg', name: "кто-то", content: 1, message: ["12"], time: "---", flag: 3, answers: [], indexOfAnswer: 0, display: true),
      Message(id: 1, status: 1, image: 'assets/Женя.jpg', name: "Хелена Боннем Картер", content: 1, message: ["13"], time: "---", flag: 1, answers: [], indexOfAnswer: 0, display: true),
      Message(id: 1, status: 1, image: 'assets/Женя.jpg', name: "кто-то", content: 1, message: ["14"], time: "---", flag: 1, answers: [], indexOfAnswer: 0, display: true),
    ];
  }

  static Future<void> initializeProfiles() async {
    await Future.delayed(const Duration(milliseconds: 10));
    profiles = [
      Profile(image: 'assets/Дарина.jpg', name: "Дарина", status: "Любитель хорроров, но до смерти боюсь Демидова", firstLink: "https://vk.com/crazy_vorobyshek", secondLink: "https://www.kinopoisk.ru/lists/movies/top_100_horrors_by_best_horror_movies/genre--horror/?utm_referrer=yandex.ru", thirdLink:"https://music.yandex.ru/album/30826697"),
      Profile(image: 'assets/Аня.jpg', name: "Аня", status: "AAAAA", firstLink: "AAAA", secondLink: "AAAA", thirdLink:"AAAA"),
      Profile(image: 'assets/Кирилл.jpg', name: "Кирилл", status: "AAAAA", firstLink: "AAAA", secondLink: "AAAA", thirdLink:"AAAA"),
      Profile(image: 'assets/Даня.jpg', name: "Даня", status: "AAAAA", firstLink: "AAAA", secondLink: "AAAA", thirdLink:"AAAA"),
      Profile(image: 'assets/Чайлдфри.jpg', name: "Чайлдфри", status: "AAAAA", firstLink: "AAAA", secondLink: "AAAA", thirdLink:"AAAA"),
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

  static void setIsMessageReadById(int id) {
    int index = conversations.indexWhere((conversation) => conversation.id == id);
    conversations[index].isMessageRead = true;
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

  static void updateChats(int id, int content, String lastMessage, String time) {
    int index = conversations.indexWhere((conversation) => conversation.id == id);

    if (content == 2) {
      conversations[index].lastMessage = "Изображение";
    } else {
      if (lastMessage.length > 27) {
        conversations[index].lastMessage = "${lastMessage.substring(0, 27)}...";
      } else {
        conversations[index].lastMessage = lastMessage;
      }
    }
    conversations[index].time = time;
    if (id != gameProcess.currentChat) conversations[index].isMessageRead = false;

    Conversation conversation = conversations[index];
    conversations.removeAt(index);
    conversations.insert(0, conversation);
  }

  static saveAnswer(int answer, int id, String message) {
    if ((gameProcess.countOfOpenedMessages + 1 < messages.length) && (messages[gameProcess.countOfOpenedMessages + 1].message.length > 1)) messages[gameProcess.countOfOpenedMessages + 1].indexOfAnswer = answer;

    DateTime now = DateTime.now();
    Message newMessage = Message(id: id, status: 2, image: 'assets/Женя.jpg', name: "Женя", content: 1, message: [], time: DateFormat('HH:mm').format(now), flag: 1, answers: [], indexOfAnswer: 0, display: message[0].contains('"') ? false : true);
    newMessage.message.insert(0, message);
    messages.insert(gameProcess.countOfOpenedMessages + 1, newMessage);
  }

  static String getNameByImage(String image) {
    Profile? profile = profiles.firstWhere((profile) => profile.image == image);
    return profile.name;
  }

  static String getStatusByImage(String image) {
    Profile? profile = profiles.firstWhere((profile) => profile.image == image);
    return profile.status;
  }

  static String getFirstLinkByImage(String image) {
    Profile? profile = profiles.firstWhere((profile) => profile.image == image);
    return profile.firstLink;
  }

  static String getSecondLinkByImage(String image) {
    Profile? profile = profiles.firstWhere((profile) => profile.image == image);
    return profile.secondLink;
  }

  static String getThirdLinkByImage(String image) {
    Profile? profile = profiles.firstWhere((profile) => profile.image == image);
    return profile.thirdLink;
  }
}