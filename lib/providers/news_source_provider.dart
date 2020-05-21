import 'dart:convert';

import 'package:shapp/modal/article_model.dart';
import 'package:http/http.dart' as http;

class NewsSource {
  List<ArticleModel> newssource = [];

  Future<void> getNews() async {
    String url =
        'http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=f9fdc262a01049e794b060d198cc5904';

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach(
        (element) {
          if (element['content'] != null && element['description'] != null) {
            ArticleModel articleModel = ArticleModel(
              articleProviderName: element['source']['name'],
              articleAuthor: element['author'],
              articleTitle: element['title'],
              articleDescription: element['description'],
              articleURL: element['url'],
              articleUrlToImage: element['urlToImage'],
              articleContent: element['content'],
            );

            newssource.add(articleModel);
          }
        },
      );
    }
  }
}

class CategoryNewsSource {
  List<ArticleModel> newssource = [];

  Future<void> getCategoryNews(String category) async {
    String url =
        'http://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=f9fdc262a01049e794b060d198cc5904';

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach(
        (element) {
          if (element['content'] != null && element['description'] != null) {
            ArticleModel articleModel = ArticleModel(
              articleProviderName: element['source']['name'],
              articleAuthor: element['author'],
              articleTitle: element['title'],
              articleDescription: element['description'],
              articleURL: element['url'],
              articleUrlToImage: element['urlToImage'],
              articleContent: element['content'],
            );

            newssource.add(articleModel);
          }
        },
      );
    }
  }
}
