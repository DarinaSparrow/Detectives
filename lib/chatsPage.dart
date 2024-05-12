import 'package:flutter/material.dart';
import 'gameProcess.dart';
import 'chatManager.dart';

class chatsPage extends StatefulWidget {
  const chatsPage({super.key});

  @override
  _chatsPageState createState() => _chatsPageState();
}

class _chatsPageState extends State<chatsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: conversationManager.conversations.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              gameProcess.changeCurrentChat(conversationManager.conversations[index].id);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => detailedChatPage(chatsId: conversationManager.conversations[index].id),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(conversationManager.conversations[index].image),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              conversationManager.conversations[index].name,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 3,),
                            Text(
                              conversationManager.conversations[index].lastMessage,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            if (!conversationManager.conversations[index].isMessageRead)
                              CircleAvatar(
                                radius: 5,
                                backgroundColor: Colors.blue[600],
                              ),
                            const SizedBox(height: 3,),
                            Text(
                              conversationManager.conversations[index].time,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class detailedChatPage extends StatefulWidget {

  final int chatsId;

  const detailedChatPage({super.key, required this.chatsId});

  @override
  _detailedChatPageState createState() => _detailedChatPageState();
}

class _detailedChatPageState extends State<detailedChatPage> {

  static final List<Message> _localMessages = [];
  bool _isAnswersVisible = false;

  @override
  void initState() {
    super.initState();

    for (var message in conversationManager.messages) {
      if (message.id == widget.chatsId) {
        _localMessages.add(message);
      }

      //if (_localMessages.length >= gameProcess.countOfOpenedMessages) {
      // break;
      // }
    }
  }

  void addMessageToList(Message message) {
    _localMessages.add(message);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue[200],
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                const SizedBox(width: 12,),
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios,color: Colors.black,),
                ),
                const SizedBox(width: 8,),
                CircleAvatar(
                  backgroundImage: AssetImage(conversationManager.getImageById(widget.chatsId)),
                  maxRadius: 20,
                ),
                const SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(conversationManager.getNameById(widget.chatsId) ,style: const TextStyle( fontSize: 16, fontWeight: FontWeight.w600),),
                      const SizedBox(height: 3,),
                      if (conversationManager.getTypeById(widget.chatsId) == 2)
                        Text(conversationManager.getIsOnlineById(widget.chatsId) ? 'Онлайн' : 'Офлайн', style: const TextStyle(fontSize: 13),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                _isAnswersVisible = false;
              });
            },
            child: ListView.builder(
              itemCount: _localMessages.length,
              padding: EdgeInsets.only(top: 10,bottom: _isAnswersVisible ? MediaQuery.of(context).size.height * 1 / 3 + 10 : 70),
              itemBuilder: (context, index) {
                MainAxisAlignment alignment = _localMessages[index].status == 1 ? MainAxisAlignment.start : MainAxisAlignment.end;
                CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start;
                return Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: alignment,
                    crossAxisAlignment: crossAxisAlignment,
                    children: [
                      if ((conversationManager.getTypeById(widget.chatsId) == 1) && (_localMessages[index].status == 1))
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(_localMessages[index].image),
                        ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: _localMessages[index].status == 1  ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                        children: [
                          if (_localMessages[index].content != 3)
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: _localMessages[index].status == 1 ? Colors.blue[400] : Colors.blue[500],
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: _localMessages[index].status == 1  ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                                children: [
                                  if ((conversationManager.getTypeById(widget.chatsId) == 1) && (_localMessages[index].status == 1))
                                    Text(_localMessages[index].name, style: const TextStyle(fontSize: 10)),
                                  if ((conversationManager.getTypeById(widget.chatsId) == 1) && (_localMessages[index].status == 1))
                                    const SizedBox(height: 5),
                                  Text(_localMessages[index].message, style: const TextStyle(fontSize: 15)),
                                ],
                              ),
                            ),
                          if (_localMessages[index].content == 3)
                            Image.asset(
                              _localMessages[index].message,
                              width: MediaQuery.of(context).size.width * 1 / 3,
                              height: MediaQuery.of(context).size.height * 1 / 3,
                            ),
                          const SizedBox(height: 5),
                          Row (
                              children: [
                                const SizedBox(width: 5),
                                Text(_localMessages[index].time, style: const TextStyle(fontSize: 12, color: Colors.black)),
                                const SizedBox(width: 5),
                              ]
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(left: 10,bottom: 10,top: 10, right: 10),
                height: _isAnswersVisible ? MediaQuery.of(context).size.height * 1 / 3 : 60,
                width: double.infinity,
                color: Colors.blue[200],
                child: _isAnswersVisible ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isAnswersVisible = !_isAnswersVisible;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: const Text( "Первый вариант сообщения",
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isAnswersVisible = !_isAnswersVisible;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: const Text( "Второй вариант сообщения",
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isAnswersVisible = !_isAnswersVisible;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: const Text( "Третий вариант сообщения",
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isAnswersVisible = !_isAnswersVisible;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: const Text( "Написать сообщение...",
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isAnswersVisible = !_isAnswersVisible;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue[500],
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        shape: const CircleBorder(),
                      ),
                      child: const Icon(Icons.send, color: Colors.black, size: 24),
                    ),
                  ],
                )
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _localMessages.clear();
    super.dispose();
  }
}