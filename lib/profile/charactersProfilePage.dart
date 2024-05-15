import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:detectives/chat/chatManager.dart';

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
            color: Colors.blue[200],
            height: sectionDivider,
          ),
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(top: sectionDivider),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: sectionDivider),
                Text(
                  conversationManager.getNameByImage(profileImage),
                  style: TextStyle(fontSize: largeFontSize, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
                  child: Text(
                    conversationManager.getStatusByImage(profileImage),
                    style: TextStyle(fontSize: middleFontSize, color: Colors.grey[700]),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (conversationManager.getNameByImage(profileImage) != "Чайлдфри")
                      IconButton(
                        icon: const Icon(Icons.add_a_photo),
                        onPressed: () {
                          // Действие при нажатии на ссылку Instagram
                        },
                      ),
                    if (conversationManager.getNameByImage(profileImage) != "Чайлдфри")
                      GestureDetector(
                          onTap: () async {
                            String url = conversationManager.getFirstLinkByImage(profileImage);
                            if (await canLaunch(url)) await launch(url);
                          },
                          child: Text('Напиши мне Вконтакте', style: TextStyle(decoration: TextDecoration.underline, fontSize: smallFontSize))
                      )
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (conversationManager.getNameByImage(profileImage) != "Чайлдфри")
                      IconButton(
                        icon: const Icon(Icons.videogame_asset),
                        onPressed: () {
                          // Действие при нажатии на ссылку игры
                        },
                      ),
                    if (conversationManager.getNameByImage(profileImage) != "Чайлдфри")
                      GestureDetector(
                          onTap: () async {
                            String url = conversationManager.getSecondLinkByImage(profileImage);
                            if (await canLaunch(url)) await launch(url);
                          },
                          child: Text('Узнай меня получше', style: TextStyle(decoration: TextDecoration.underline, fontSize: smallFontSize))
                      )
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (conversationManager.getNameByImage(profileImage) != "Чайлдфри")
                      IconButton(
                        icon: const Icon(Icons.playlist_play),
                        onPressed: () {
                          // Действие при нажатии на альтернативный плейлист
                        },
                      ),
                    if (conversationManager.getNameByImage(profileImage) != "Чайлдфри")
                      GestureDetector(
                          onTap: () async {
                            String url = conversationManager.getThirdLinkByImage(profileImage);
                            if (await canLaunch(url)) await launch(url);
                          },
                          child: Text('Послушаем вместе музыку)))', style: TextStyle(decoration: TextDecoration.underline, fontSize: smallFontSize))
                      )
                  ],
                ),
              ],
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