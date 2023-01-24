import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

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
          inspect(articles[index]);
           return ListTile(
              leading: Icon(Icons.album),
              title:  Text(articles[index].title),
              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            );
        });
  }
}
