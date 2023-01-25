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
                  onTap: () {
                    Navigator.of(context)
                      ..push(MaterialPageRoute(builder: (BuildContext context) {
                        return SafeArea(
                          child: Scaffold(
                            appBar: AppBar(
                              title: Text(
                                articles[index]?.title,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            body: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: SafeArea(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Image.network(
                                              articles[index]?.urlToImage),
                                          Text(
                                            articles[index].title,
                                            overflow: TextOverflow.visible,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const Padding(
                                              padding: EdgeInsets.all(20.0)),
                                          Text(
                                            articles[index].description,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        );
                      }));
                  }),
            );
          });
    } else {
      return Container(
        child: Text('No data found'),
      );
    }
  }
}
