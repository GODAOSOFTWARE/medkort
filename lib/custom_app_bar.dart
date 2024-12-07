import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60, // Высота шапки
      color: const Color(0xFF050F21), // Тёмно-синий фон
      padding: const EdgeInsets.symmetric(horizontal: 16), // Отступы
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Логотип и текст
          Row(
            children: [
              // Круг (30x30)
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: Colors.blue, // Синий цвет круга
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8), // Отступ между кругом и текстом
              Text(
                'Медкорт',
                style: GoogleFonts.nunitoSans(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // Кнопка "Открыть меню"
          ElevatedButton(
            onPressed: () {
              debugPrint('Открыть меню нажато');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Цвет кнопки
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: Text(
              'Открыть меню',
              style: GoogleFonts.nunitoSans(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60); // Высота шапки
}
