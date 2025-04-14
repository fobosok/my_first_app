import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.brightness_6),
      tooltip: 'Сменить тему',
      onPressed: () {
        final controller = Provider.of<ThemeController>(context, listen: false);
        controller.toggleTheme(); // Переключаем тему
      },
    );
  }
}