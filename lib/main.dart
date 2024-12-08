import 'dart:html'; // Для IFrameElement
import 'dart:ui' as ui; // Для регистрации IFrameElement
import 'package:flutter/material.dart';
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
      home: const MyHomePage(),
    );
  }
}

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
                selectedIcon: Icon(Icons.medical_services),
                icon: Icon(Icons.medical_services_outlined),
                label: 'Лечение',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
