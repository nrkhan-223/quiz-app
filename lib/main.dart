import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:quizeapp/screens/start_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSharePref();
  runApp(const MainApp());
}
late SharedPreferences pref;
initSharePref() async {
  pref = await SharedPreferences.getInstance();
  log(pref.get("Score").toString());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark().copyWith(),
      home: const StartScreen(),
    );
  }
}
