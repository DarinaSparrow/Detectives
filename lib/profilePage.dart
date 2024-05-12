import 'package:flutter/material.dart';
import 'userSettings.dart';

class profilePage extends StatefulWidget {
  const profilePage({Key? key}) : super(key: key);

  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildSectionTitle('Расскажи друзьям о себе'),
                  _buildDivider(),
                  _buildProfileField('Ник', 'Введите имя', _nicknameController),
                  _buildDivider(),
                  _buildProfileField('Статус', 'Введите статус', _statusController),
                  _buildDivider(),
                  _buildSectionTitle('Настройки'),
                  _buildDivider(),
                  _buildSettingItem('Скорость сообщения', _buildSpeedOptions()),
                  _buildDivider(),
                  _buildSettingSwitch('Вибрация', userSettings.vibration, (newValue) {
                    setState(() {
                      userSettings.vibration = newValue;
                    });
                  }),
                  _buildDivider(),
                  _buildSettingSwitch('Звук', userSettings.sound, (newValue) {
                    setState(() {
                      userSettings.sound = newValue;
                    });
                  }),
                  _buildDivider(),
                  _buildSettingSwitch('Музыка', userSettings.music, (newValue) {
                    setState(() {
                      userSettings.music = newValue;
                    });
                  }),
                  _buildDivider(),
                  _buildSectionTitle('Сохраненная игра'),
                  _buildDivider(),
                  _buildSettingButton('Загрузить сохранение'),
                  _buildDivider(),
                  _buildSettingButton('Перезапустить историю'),
                  _buildDivider(),
                  _buildSectionTitle('Конфиденциальность'),
                  _buildDivider(),
                  _buildPrivacyButton('Политика конфиденциальности'),
                  _buildDivider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildProfileField(String label, String hintText, TextEditingController controller) {
    controller.text = label == "Ник" ? userSettings.nickname : userSettings.status;
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 3,
          child: TextField(
            controller: controller,
            onChanged: (value) {
              if (label == "Ник") {
                userSettings.nickname = value;
              } else {
                userSettings.status = value;
              }
            },
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[500]),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: Colors.grey,
      thickness: 1,
    );
  }

  Widget _buildSettingItem(String label, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        child,
      ],
    );
  }

  Widget _buildSpeedOptions() {
    return Row(
      children: [
        const Expanded(
          flex: 1,
          child: Text(
            'Скорость сообщений',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSpeedButton(Icons.keyboard_arrow_right, 1),
              _buildSpeedButton(Icons.play_arrow, 2),
              _buildSpeedButton(Icons.double_arrow_outlined, 3),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSpeedButton(IconData icon, int speedValue) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              userSettings.selectedSpeed = speedValue;
            });
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all<CircleBorder>(
              const CircleBorder(),
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
              if (userSettings.selectedSpeed == speedValue) {
                return Colors.blue;
              }
              return Colors.grey;
            }),
          ),
          child: Icon(icon, size: 30),
        ),
      ],
    );
  }

  Widget _buildSettingSwitch(String label, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildSettingButton(String label) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(label),
    );
  }

  Widget _buildPrivacyButton(String label) {
    return TextButton(
      onPressed: () {},
      child: Text(label),
    );
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _statusController.dispose();
    super.dispose();
  }

}