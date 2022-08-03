import 'package:equatable/equatable.dart';

class Article extends Equatable {
  const Article({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  final int id;
  final int userId;
  final String title;
  final String body;

  // ignore: sort_constructors_first
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  @override
  List<Object> get props => [
        userId,
        id,
        title,
        body,
      ];
}

List<Article> articleToList(List<Map<String, dynamic>> articles) {
  return List<Article>.from(
    articles.map(
      Article.fromJson,
    ),
  );
}
