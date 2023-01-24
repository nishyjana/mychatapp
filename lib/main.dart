import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mychatapp/Reference/refernceCode.dart';
import 'package:mychatapp/chat_screen.dart';

void main() {
  dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyBestieApp with chatGPT',
      color: Colors.deepPurpleAccent,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          color: Color.fromARGB(255, 218, 166, 34), //<-- SEE HERE
        ),
      ),
      home: const MyHomePage(
        title: 'My Bosom Buddy',
      ),
    );
  }
}
