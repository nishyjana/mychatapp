import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({super.key, required this.articles});

  final articles;

  @override
  Widget build(BuildContext context) {
    // MatchEngine? _matchEngine;
    // List<SwipeItem> _swipeItems = [];
    // _matchEngine = MatchEngine(swipeItems: _swipeItems);
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          return ListTile(
              leading: index <= 99 ? Icon(Icons.album_rounded): null,
              title: index <= 99 ? Text(articles[index].title): null,
              subtitle: index <= 99 ? Text(articles[index].url): null,
            );
        });
  }
}
