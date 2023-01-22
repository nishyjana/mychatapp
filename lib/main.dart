import 'package:flutter/material.dart';
import 'package:mychatapp/chat_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyBestieApp with chatGPT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan, 
        useMaterial3: true,
      ),
      home: const ChatScreen(),
    );
  }
}

