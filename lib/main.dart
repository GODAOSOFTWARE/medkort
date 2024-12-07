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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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
          // Нижнее меню
          Container(
            height: 60, // Высота нижнего меню
            color: const Color(0xFF050F21), // Тёмно-синий цвет
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBottomNavItem(Icons.person, 'Профиль'),
                _buildBottomNavItem(Icons.account_balance_wallet, 'Кошелек'),
                _buildBottomNavItem(Icons.calendar_today, 'Приемы'),
                _buildBottomNavItem(Icons.medical_services, 'Лечение'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.white.withOpacity(0.7), // Цвет иконки
          size: 20, // Размер иконки уменьшен
        ),
        const SizedBox(height: 4), // Отступ между иконкой и текстом
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7), // Цвет текста
            fontSize: 11, // Размер текста уменьшен
          ),
        ),
      ],
    );
  }
}
