import 'package:flutter/material.dart';

class ArticlePageContent extends StatelessWidget {
  ArticlePageContent(
      {@required this.aTitle, @required this.aContent, @required this.aName});

  final String aTitle;
  final String aContent;
  final String aName;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('#TopNews'), Text('Monday at 5:30 AM')],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white10),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    aName,
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black12),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    aTitle,
                    style:
                        TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    aContent,
                    style: TextStyle(
                        fontSize: 20.0, height: 1.5, color: Colors.grey),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
