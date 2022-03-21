import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import '../../themes.dart';

class EditAppBar extends StatelessWidget {
  const EditAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final icon = isDarkMode ? Icons.light_mode : Icons.dark_mode;

    return AppBar(
      backgroundColor: Colors.blue.shade900,
      title: const Text('Employee dialog'),
      centerTitle: true,
      leading: const BackButton(
        color: Colors.white,
      ),
      elevation: 0,
      actions: [
        ThemeSwitcher(
          builder: (context) => IconButton(
            icon: Icon(icon),
            onPressed: () {
              final theme =
                  isDarkMode ? MyThemes.lightTheme : MyThemes.darkTheme;
              final switcher = ThemeSwitcher.of(context)!;
              switcher.changeTheme(theme: theme);
            },
          ),
        ),
      ],
    );
  }
}
