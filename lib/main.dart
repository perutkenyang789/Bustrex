import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/themes.dart';
import 'presentation/screens/home_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bustrex Demo',
      theme: AppTheme.defaultTheme,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
