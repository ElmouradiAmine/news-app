import 'package:flutter/material.dart';
import 'package:shapp/modal/article_page_content.dart';
import 'package:shapp/modal/article_page_header.dart';

class ArticleView extends StatefulWidget {
  final String articleImageUrl;
  final String articleTitle;
  final String articleContent;
  final String articleSourceName;

  ArticleView(
      {this.articleImageUrl,
      this.articleTitle,
      this.articleContent,
      this.articleSourceName});

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
              pinned: false,
              floating: true,
              delegate: ArticlePageHeader(
                minExtent: 150.0,
                maxExtent: 300.0,
                aImageUrl: widget.articleImageUrl,
              )),
          ArticlePageContent(
            aTitle: widget.articleTitle,
            aContent: widget.articleContent,
            aName: widget.articleSourceName,
          )
        ],
      ),
    );
  }
}
