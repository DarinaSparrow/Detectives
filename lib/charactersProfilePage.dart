import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:detectives/chatManager.dart';

class charactersProfilePage extends StatelessWidget {
  const charactersProfilePage({super.key, required this.profileImage});

  final String profileImage;

  @override
  Widget build(BuildContext context) {
    double avatarRadius = MediaQuery.of(context).size.width * 0.2;
    double sectionDivider = MediaQuery.of(context).size.height * 0.15;
    double largeFontSize = MediaQuery.of(context).size.height * 0.03;
    double middleFontSize = MediaQuery.of(context).size.height * 0.025;
    double smallFontSize = MediaQuery.of(context).size.height * 0.02;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.blueGrey, // Серый цвет фона
            height: sectionDivider,
          ),
          Container(
            color: Colors.white, // Белый цвет фона
            height: MediaQuery.of(context).size.height, // Высота второго контейнера (весь экран)
            margin: EdgeInsets.only(top: sectionDivider), // Отступ сверху (равен высоте первого контейнера)
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: sectionDivider),
                  Text(
                    'Name',
                    //conversationManager.getNameByImage(profileImage),
                    style: TextStyle(fontSize: largeFontSize, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Status',
                    //conversationManager.getStatusByImage(profileImage),
                    style: TextStyle(fontSize: middleFontSize, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add_a_photo),
                        onPressed: () {
                          // Действие при нажатии на ссылку Instagram
                        },
                      ),
                      Text(
                        'firstLink',
                        //'Я Вконтакте: ${conversationManager.getFirstLinkByImage(profileImage)}',
                        style: TextStyle(fontSize: smallFontSize),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.videogame_asset),
                        onPressed: () {
                          // Действие при нажатии на ссылку игры
                        },
                      ),
                      Text(
                        'secondLink',
                        //'Я не Вконтакте: ${conversationManager.getFirstLinkByImage(profileImage)}',
                        style: TextStyle(fontSize: smallFontSize),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.playlist_play),
                        onPressed: () {
                          // Действие при нажатии на альтернативный плейлист
                        },
                      ),
                      Text(
                        'Альтернативный плейлист - лучшее',
                        style: TextStyle(fontSize: smallFontSize),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: sectionDivider - avatarRadius, // Положение аватара по вертикали (половина экрана - половина размера аватара)
            left: MediaQuery.of(context).size.width * 0.5 - avatarRadius, // Положение аватара по горизонтали (половина экрана - половина размера аватара)
            child: CircleAvatar(
              radius: avatarRadius,
              backgroundImage: AssetImage(
                  profileImage, ),
            ),
          ),
        ],
      ),
    );
  }
}