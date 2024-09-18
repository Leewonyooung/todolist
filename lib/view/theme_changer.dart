import 'package:flutter/material.dart';
import 'package:todolist_v2/main.dart';

class ThemeChanger extends StatefulWidget {
  const ThemeChanger({super.key});

  @override
  State<ThemeChanger> createState() => _ThemeChangerState();
}

class _ThemeChangerState extends State<ThemeChanger> {
  bool _isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        centerTitle: true,
        title: const Text(
          '테마',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      body: Center(
        child: Switch(
          value: _isDarkMode,
          onChanged: (val) {
            setState(() {
              _isDarkMode = val;
            });

            MyApp.themeNotifier.value =
                MyApp.themeNotifier.value == ThemeMode.light
                    ? ThemeMode.dark
                    : ThemeMode.light;
          },
        ),
      ),
    );
  }
}
