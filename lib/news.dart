import 'package:link_preview_generator/link_preview_generator.dart';
import 'package:flutter/material.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({super.key, required this.articles});

  final articles;

  @override
  Widget build(BuildContext context) {
    if (articles.length > 0) {
      return ListView.builder(
          padding: const EdgeInsets.all(20.0),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(10.0),
              child: LinkPreviewGenerator(
                bodyMaxLines: 5,
                link: index <= 99 ? articles[index]?.url : '',
                linkPreviewStyle: LinkPreviewStyle.large,
                showGraphic: true,
                bodyTextOverflow: TextOverflow.fade,
                showDomain: true,
                onTap: () {},
              ),
            );
          });
    } else {
      return Container(
        child: Text('No data found'),
      );
    }
  }
}
