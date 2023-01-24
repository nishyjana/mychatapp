import 'dart:convert';  
// News newsFromJson(String str) => News.fromJson(json.decode(str));
// String newsToJson(News data) => json.encode(data.toJson());
class News {
  final String status;
  final int totalResults;
  final List<Articles> articles;

  const News({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: List<Articles>.from(json["articles"].map((x) => Articles.fromJson(x))),
    );
  }
   Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
    };
}

class Articles {
  final String title;

  const Articles({
    required this.title,
  });

  factory Articles.fromJson(Map<String, dynamic> json) {
    return Articles(title: json['title']);
  }
  Map<String, dynamic> toJson() => {
        "title": title
    };
}
