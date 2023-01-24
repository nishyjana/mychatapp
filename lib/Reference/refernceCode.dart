import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mychatapp/Modal/news_modal.dart';
import 'package:mychatapp/chat_screen.dart';
import '../news.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyBestieApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'My Bestie App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const ChatScreen()));
  }

  Future<News> _fetchNews() async {
     var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    var url = 'https://newsapi.org/v2/everything?' +
          'q=apple&' +
         // 'from=2023-01-24&'+
          'from='+formattedDate+'&' +
          'pageSize=1000'+
          'sortBy=popularity&' +
          'apiKey=e2f70d4225c74a50be318638952e7779';
    final response = await http
        .get(Uri.parse(url));
    inspect(response);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return News.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  late Future<News> news;

  @override
  void initState() {
    super.initState();
    news = _fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: FutureBuilder<News>(
          future: news,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              inspect(snapshot.data?.articles);
              return NewsWidget(
                articles: snapshot.data?.articles,
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToNextScreen(context);
        },
        tooltip: 'Lets chat',
        child: const Icon(Icons.message_outlined),
      ),
    );
  }
}
