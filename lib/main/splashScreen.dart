import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main/sceletonOfApp.dart';
import '../service/gameProcess.dart';
import '../service/dataManager.dart';
import '../service/appService.dart';
import 'dart:async';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen>
    with SingleTickerProviderStateMixin {
  double _progress = 0.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loading();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  void _loading() async {
    const loadingTimeInSeconds = 3; // Фиксированное время загрузки в секундах
    const updateInterval = 50; // Интервал обновления прогресса в миллисекундах

    // Обновление прогресса каждый интервал updateInterval миллисекунд
    Timer.periodic(Duration(milliseconds: updateInterval), (timer) {
      setState(() {
        _progress = timer.tick *
            updateInterval /
            (loadingTimeInSeconds * 1000); // Обновление прогресса по таймеру
      });

      // Проверка окончания загрузки
      if (timer.tick * updateInterval >= loadingTimeInSeconds * 1000) {
        timer.cancel(); // Остановка таймера по окончании загрузки
        setState(() {
          // Завершение загрузки
          _isLoading = false; // Установка флага окончания загрузки
        });
      }
    });

    // Загрузка ресурсов в асинхронном режиме
    _loadResources();
  }

  Future<void> _loadResources() async {
    try {
      // Загрузка данных и ресурсов
      await dataManager.startFromAssets();
      await appService.initialize();
    } catch (e) {
      print('Ошибка загрузки ресурсов: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image(
              fit: BoxFit.fill,
                image: AssetImage('assets/images/splashScreen.jpg'),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.05,
                  MediaQuery.of(context).size.width * 0.3,
                  MediaQuery.of(context).size.width * 0.05,
                  MediaQuery.of(context).size.width * 0.05
              ),
              child: Text(
                'ТАИНСТВЕННАЯ ПРОПАЖА',
                //softWrap: true,
                textAlign: TextAlign.center,
                //overflow: TextOverflow.visible,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.1,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NIT',
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.25),
              child: _isLoading
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          value: _progress,
                          backgroundColor: Colors.white,
                        ),
                        Text(
                          '${(_progress * 100).round()}%',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  : SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      height: MediaQuery.of(context).size.width * 0.12,
                      child: ElevatedButton(
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const sceletonOfApp()),
                          );
                          gameProcess.updateDuration();
                          gameProcess.runGameLoop();
                        },
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Text(
                            'Гоу ту мессенждер',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.1,
                              color: Colors.black,
                              // fontWeight: FontWeight.bold,
                              // fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
