import 'package:flutter/material.dart';
import 'dart:async';
import '../service/gameProcess.dart';
import 'chatManager.dart';
import '../profile/charactersProfilePage.dart';

class chatsPage extends StatefulWidget {
  const chatsPage({super.key});

  @override
  _chatsPageState createState() => _chatsPageState();
}

class _chatsPageState extends State<chatsPage> {

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    updateChatsPage();
  }

  Future<void> updateChatsPage() async {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {

      setState(() {});
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backgroundforchatslist.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: conversationManager.conversations.length,
          itemBuilder: (context, index) {
            if (conversationManager.conversations[index].countOfOpenedMessages <= gameProcess.countOfOpenedMessages) {
              return GestureDetector(
                onTap: () {
                  conversationManager.setIsMessageReadById(conversationManager.conversations[index].id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          detailedChatPage(
                              chatsId: conversationManager.conversations[index].id),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.teal[50],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (conversationManager.conversations[index].id != 1) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    charactersProfilePage(
                                        profileImage: conversationManager
                                            .conversations[index].image)),
                              );
                            }
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage(
                                conversationManager.conversations[index].image),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                conversationManager.conversations[index].name,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 2,),
                              Text(
                                conversationManager.conversations[index]
                                    .lastMessage,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            if (!conversationManager.conversations[index]
                                .isMessageRead)
                              CircleAvatar(
                                radius: 5,
                                backgroundColor: Colors.teal[900],
                              ),
                            const SizedBox(height: 2,),
                            Text(
                              conversationManager.conversations[index].time,
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
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
  final ScrollController _scrollController = ScrollController();
  bool _isAnswersVisible = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    gameProcess.changeCurrentChat(widget.chatsId);

    for (int i = 0; i <= gameProcess.countOfOpenedMessages; i++) {
      if (conversationManager.messages[i].id == widget.chatsId) {
        _localMessages.add(conversationManager.messages[i]);
      }
    }

    updateChat();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> updateChat() async {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {

      bool updated = false;
      if ((conversationManager.messages[gameProcess.countOfOpenedMessages].id == widget.chatsId)
          && ((_localMessages.isEmpty) || (conversationManager.messages[gameProcess.countOfOpenedMessages].message != _localMessages[_localMessages.length - 1].message))) {
        _localMessages.add(conversationManager.messages[gameProcess.countOfOpenedMessages]);

        updated = true;

        if (_localMessages.length > 30){
          _localMessages.removeAt(0);
        }
      }

      setState(() {});
      if (updated == true) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      }
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.cyan[600],
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
                GestureDetector(
                  onTap: () {
                    if (widget.chatsId != 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => charactersProfilePage(profileImage: conversationManager.getImageById(widget.chatsId))),
                      );
                    }
                  },
                  child: CircleAvatar(
                    backgroundImage: AssetImage(conversationManager.getImageById(widget.chatsId)),
                    maxRadius: 20,
                  ),
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
                        Text(conversationManager.getIsOnlineById(widget.chatsId) ? 'Онлайн' : 'Офлайн', style: const TextStyle(fontSize: 14),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/backgroundforchat.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child:      Stack(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isAnswersVisible = false;
                  });
                },
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _localMessages.length,
                    padding: EdgeInsets.only(top: 10,bottom: _isAnswersVisible ? MediaQuery.of(context).size.height * 1 / 3 + 10 : 70),
                    itemBuilder: (context, index) {
                      if (_localMessages[index].display) {
                        if (_localMessages[index].status != 3) {
                          MainAxisAlignment alignment = _localMessages[index].status == 1 ? MainAxisAlignment.start : MainAxisAlignment.end;
                          CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start;
                          return Container(
                            padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              children: [
                                if ((conversationManager.getTypeById(widget.chatsId) == 1) && (_localMessages[index].status == 1))
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => charactersProfilePage(profileImage: _localMessages[index].image)),
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundImage: AssetImage(_localMessages[index].image),
                                    ),
                                  ),
                                if ((conversationManager.getTypeById(widget.chatsId) == 1) && (_localMessages[index].status == 1))
                                  const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: _localMessages[index].status == 1 ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                                    children: [
                                      if (_localMessages[index].content == 1)
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: _localMessages[index].status == 1 ? Colors.cyan[50] : Colors.cyan[200],
                                          ),
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment: _localMessages[index].status == 1 ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                                            children: [
                                              if ((conversationManager.getTypeById(widget.chatsId) == 1) && (_localMessages[index].status == 1))
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => charactersProfilePage(profileImage: _localMessages[index].image)),
                                                    );
                                                  },
                                                  child: Text(_localMessages[index].name, style: const TextStyle(fontSize: 12)),
                                                ),
                                              if ((conversationManager.getTypeById(widget.chatsId) == 1) && (_localMessages[index].status == 1))
                                                const SizedBox(height: 5),
                                              Text(
                                                _localMessages[index].message[_localMessages[index].indexOfAnswer],
                                                style: const TextStyle(fontSize: 15),
                                                textAlign: TextAlign.left,
                                              ),
                                            ],
                                          ),
                                        ),
                                      if (_localMessages[index].content == 2)
                                        Image.asset(
                                          _localMessages[index].message[_localMessages[index].indexOfAnswer],
                                          width: MediaQuery.of(context).size.width * 1 / 3,
                                          height: MediaQuery.of(context).size.width * 1 / 3,
                                        ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const SizedBox(width: 5),
                                          Text(_localMessages[index].time, style: const TextStyle(fontSize: 12, color: Colors.white)),
                                          const SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        else {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Text(_localMessages[index].message[_localMessages[index].indexOfAnswer], textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          );
                        }
                      }
                      if (!_localMessages[index].display){
                        return const SizedBox.shrink();
                      }
                    }
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
                color: Colors.cyan[600],
                child: _isAnswersVisible ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          conversationManager.saveAnswer(0, widget.chatsId, _localMessages[_localMessages.length - 1].answers[0]);
                          setState(() {
                            _isAnswersVisible = false;
                          });
                          gameProcess.changeChatWithOpenAnswers();
                          gameProcess.runPlot();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan[50],
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child:
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(((_localMessages.isNotEmpty) && (_localMessages[_localMessages.length - 1].answers.length > 1)) ? _localMessages[_localMessages.length - 1].answers[0] : " ",
                            style: const TextStyle(color: Colors.black),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          conversationManager.saveAnswer(1, widget.chatsId, _localMessages[_localMessages.length - 1].answers[1]);
                          setState(() {
                            _isAnswersVisible = false;
                          });
                          gameProcess.changeChatWithOpenAnswers();
                          gameProcess.runPlot();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan[50],
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(((_localMessages.isNotEmpty) && (_localMessages[_localMessages.length - 1].answers.length > 1)) ? _localMessages[_localMessages.length - 1].answers[1] : " ",
                            style: const TextStyle(color: Colors.black),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          conversationManager.saveAnswer(2, widget.chatsId, _localMessages[_localMessages.length - 1].answers[2]);
                          setState(() {
                            _isAnswersVisible = false;
                          });
                          gameProcess.changeChatWithOpenAnswers();
                          gameProcess.runPlot();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan[50],
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(((_localMessages.isNotEmpty) && (_localMessages[_localMessages.length - 1].answers.length > 1)) ? _localMessages[_localMessages.length - 1].answers[2] : " ",
                            style: const TextStyle(color: Colors.black),
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
                          if (gameProcess.chatWithOpenAnswers == widget.chatsId) {
                            setState(() {
                            _isAnswersVisible = true;
                          });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan[50],
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child:
                          Text((gameProcess.chatWithOpenAnswers == widget.chatsId) ? "Написать сообщение..." : " ",
                            style: const TextStyle(color: Colors.black),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (gameProcess.chatWithOpenAnswers == widget.chatsId) {
                          setState(() {
                            _isAnswersVisible = true;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan[800],
                        shadowColor: Colors.transparent,
                        //padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        shape: const CircleBorder(),
                      ),
                      child: const Icon(Icons.send, color: Colors.white, size: 24),
                    ),
                  ],
                )
            ),
          ),
        ],
      ),
      )
    );
  }

  @override
  void dispose() {
    _timer?.cancel();

    gameProcess.changeCurrentChat(0);

    _localMessages.clear();

    _scrollController.dispose();
    super.dispose();
  }
}