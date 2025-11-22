import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const KoynDexApp());
}

class KoynDexApp extends StatelessWidget {
  const KoynDexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KoynDexApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
      ),
      home: const LoginScreen(),
    );
  }
}
 