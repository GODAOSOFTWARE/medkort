import 'dart:html'; // Для IFrameElement
import 'dart:ui' as ui; // Для регистрации IFrameElement
import 'package:flutter/material.dart';
import 'dart:async'; // Для таймера
import 'custom_app_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WebView App',
      theme: ThemeData.dark(), // Тёмная тема
      home: const SplashScreen(), // Начальная загрузочная страница
    );
  }
}

// Загрузочный экран
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _simulateLoading();
  }

  void _simulateLoading() {
    // Эмуляция загрузки
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        _progress += 0.02;
        if (_progress >= 1.0) {
          timer.cancel();
          _navigateToHome();
        }
      });
    });
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const MyHomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Фоновое изображение
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/loading_screen.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Прогресс-бар внизу экрана
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: LinearProgressIndicator(
                value: _progress,
                backgroundColor: Colors.grey.shade700,
                color: Colors.amber,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Основной экран с WebView
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Создание IFrameElement для Flutter Web
    final IFrameElement iframe = IFrameElement()
      ..src = 'https://medkort.ru/' // Указываем URL
      ..style.border = 'none'; // Убираем границу

    // Регистрация IFrameElement как виджета для Flutter Web
    // Игнорируем ошибки безопасности с использованием `ui.platformViewRegistry`
    // Только для Web!
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
      (int viewId) => iframe,
    );

    return Scaffold(
      appBar: CustomAppBar(), // Шапка
      body: Column(
        children: [
          // IFrame для отображения сайта
          Expanded(
            child: HtmlElementView(viewType: 'iframeElement'),
          ),
          // Нижнее меню (NavigationBar)
          NavigationBar(
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            selectedIndex: currentPageIndex,
            destinations: const [
              NavigationDestination(
                selectedIcon: Icon(Icons.person),
                icon: Icon(Icons.person_outline),
                label: 'Анкета',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.account_balance_wallet),
                icon: Icon(Icons.account_balance_wallet_outlined),
                label: 'Кошелек',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.calendar_today),
                icon: Icon(Icons.calendar_today_outlined),
                label: 'Приемы',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.more_horiz),
                icon: Icon(Icons.more_horiz_outlined),
                label: 'Еще',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
