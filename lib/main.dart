import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:todolist_v2/view/table_list.dart';

void main() async {
  await GetStorage.init();
  await initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);
  static const seedColor = Color.fromARGB(255, 224, 211, 171);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('ko', 'KR'), // Korean, no country code
      ],
      theme: ThemeData(
        fontFamily: 'leaf',
        colorSchemeSeed: seedColor,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const TableList(),
      },
      initialRoute: '/',
      debugShowCheckedModeBanner: false, // 디버그 표시 제거
    );
  }
}
