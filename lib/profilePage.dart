import 'package:flutter/material.dart';

class profilePage extends StatelessWidget {
  const profilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.blueGrey, // Серый цвет фона
            height: MediaQuery.of(context).size.height * 0.2, // Высота первого контейнера (половина экрана)
          ),
          Container(
            color: Colors.white, // Белый цвет фона
            height: MediaQuery.of(context).size.height, // Высота второго контейнера (весь экран)
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2), // Отступ сверху (равен высоте первого контейнера)
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30),
                  Text(
                    'Имя пользователя',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Статус пользователя',
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.add_a_photo),
                        onPressed: () {
                          // Действие при нажатии на ссылку Instagram
                        },
                      ),
                      Text(
                        'Подпишитесь на меня в Instagram',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.videogame_asset),
                        onPressed: () {
                          // Действие при нажатии на ссылку игры
                        },
                      ),
                      Text(
                        'Я в игре!',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.playlist_play),
                        onPressed: () {
                          // Действие при нажатии на альтернативный плейлист
                        },
                      ),
                      Text(
                        'Альтернативный плейлист - лучшее',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2 - 50, // Положение аватара по вертикали (половина экрана - половина размера аватара)
            left: MediaQuery.of(context).size.width * 0.5 - 50, // Положение аватара по горизонтали (половина экрана - половина размера аватара)
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  'https://i.pinimg.com/564x/1b/35/f4/1b35f423b1f9b3e10b69ae47692bd81c.jpg'),
            ),
          ),
        ],
      ),
    );
  }
}