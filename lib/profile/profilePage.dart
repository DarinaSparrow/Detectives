import 'package:detectives/service/dataManager.dart';
import 'package:detectives/service/gameProcess.dart';
import 'package:flutter/material.dart';
import '../service/userSettings.dart';
import '../service/appService.dart';

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
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/backgroundforcallsandprofile.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.04),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildProfileAvatar('assets/images/Женя.jpg'),
                      _buildProfileInfo('Женя', 'Да что вы опять смеетесь?'),
                      _buildDivider(),
                      _buildSectionTitle('Настройки'),
                      _buildDivider(),
                      _buildSettingItem('Скорость сообщения', _buildSpeedOptions()),
                      _buildDivider(),
                      _buildSettingSwitch('Вибрация', userSettings.vibration,
                              (newValue) {
                            setState(() {
                              userSettings.vibration = newValue;
                            });
                            dataManager.saveSettings();
                            appService.vibrate(duration: 300, amplitude: 100);
                          }),
                      _buildDivider(),
                      _buildSettingSwitch('Звук', userSettings.sound, (newValue) {
                        setState(() {
                          userSettings.sound = newValue;
                        });
                        dataManager.saveSettings();
                      }),
                      _buildDivider(),
                      _buildSettingButton('Перезапустить историю'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

  Widget _buildProfileAvatar(String profileImage) {
    double avatarRadius = MediaQuery.of(context).size.width * 0.2;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: avatarRadius,
            backgroundImage: AssetImage(profileImage),
          ),
        ]);
  }

  Widget _buildProfileInfo(String name, String status) {
    double largeFontSize = MediaQuery.of(context).size.height * 0.03;
    double middleFontSize = MediaQuery.of(context).size.height * 0.025;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: largeFontSize,
        ),
        Text(
          name,
          style:
              TextStyle(fontSize: largeFontSize, fontWeight: FontWeight.bold),
        ),
        Text(
          status,
          style: TextStyle(
              fontSize: middleFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700]),
        ),
        SizedBox(
          height: largeFontSize,
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    double middleFontSize = MediaQuery.of(context).size.height * 0.025;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.01),
      child: Text(
        title,
        style: TextStyle(fontSize: middleFontSize, fontWeight: FontWeight.bold),
      ),
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
            appService.vibrate();
            setState(() {
              userSettings.selectedSpeed = speedValue;
              gameProcess.updateDuration();
            });
            dataManager.saveSettings();
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all<CircleBorder>(
              const CircleBorder(),
            ),
            side: MaterialStateProperty.all(
                BorderSide(
                  color: Colors.grey.shade600,
                  width: 2.0,
                )
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (userSettings.selectedSpeed == speedValue) {
                    return Colors.teal.shade800;
                  }
                  return Colors.white70;
                }
            ),

          ),
          child: Icon(
            icon,
            color: userSettings.selectedSpeed == speedValue ? Colors.white : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingSwitch(
      String label, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Switch(
          value: value,
          activeColor: Colors.white,
          activeTrackColor: Colors.teal.shade700,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildSettingButton(String label) {
    return ElevatedButton(
      style: ButtonStyle(
        side: MaterialStateProperty.all(
            BorderSide(
              color: Colors.grey.shade600,
              width: 2.0,
            )
        ),
      ),
      onPressed: () {
        appService.vibrate();
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Подтверждение'),
            content:
                const Text('Вы уверены, что хотите перезапустить историю?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  appService.vibrate();
                  Navigator.pop(context, 'Нет');
                },
                child: const Text('Нет'),
              ),
              TextButton(
                onPressed: () {
                  appService.vibrate();
                  dataManager.resetGameProgress();
                  Navigator.pop(context, 'Да');
                },
                child: const Text('Да'),
              ),
            ],
          ),
        );
      },
      child: Text(
          label,
          style: const TextStyle(
            color: Colors.black,
          ),
      ),
    );
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _statusController.dispose();
    super.dispose();
  }
}
