import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shapp/Screens/setting_screen.dart';
import 'package:shapp/modal/article_view.dart';
import 'package:shapp/providers/category_provider.dart';
import 'package:shapp/providers/news_source_provider.dart';
import 'package:shapp/modal/article_model.dart';
import 'package:shapp/modal/category_model.dart';

class NewsScreen extends StatefulWidget {
  static const String id = 'news_screen';
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<CategoryModel> categories = List<CategoryModel>();
  List<ArticleModel> articles = List<ArticleModel>();
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    getNewsSource();
  }

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  getNewsSource({String category = 'Recent'}) async {
    setState(() {
      _loading = true;
    });
    if (category == 'Recent') {
      NewsSource newsSource = NewsSource();
      await newsSource.getNews();
      articles = newsSource.newssource;
    } else {
      CategoryNewsSource categoryNewsSource = CategoryNewsSource();
      await categoryNewsSource.getCategoryNews(category);
      articles = categoryNewsSource.newssource;
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context);

    // Here we add a listener  in our news screen to the changes on the value of category
    categoryProvider.addListener(() {
      // When the category changes please fetch the news of that category and update the screen.
      getNewsSource(category: categoryProvider.category);
    });
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      endDrawer: UserDrawer(),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  floating: false,
                  pinned: false,
                  elevation: 0.0,
                  actions: <Widget>[
                    IconButton(
                        icon: Icon(Icons.person),
                        onPressed: () {
                          _scaffoldKey.currentState.openEndDrawer();
                        })
                  ],
                  expandedHeight: 275.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(categoryProvider.category),
                    background: Image.network(
                      'https://media4.s-nbcnews.com/i/newscms/2019_01/2705191/nbc-social-default_b6fa4fef0d31ca7e8bc7ff6d117ca9f4.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverFixedExtentList(
                  itemExtent: 200,
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return NewsTile(
                      imageURL: articles[index].articleUrlToImage,
                      title: articles[index].articleTitle,
                      name: articles[index].articleProviderName,
                      content: articles[index].articleContent,
                    );
                  }, childCount: articles.length),
                ),
              ],
            ),
    );
  }
}

///News Block

class NewsTile extends StatelessWidget {
  final String imageURL, title, name, content;

  NewsTile(
      {@required this.imageURL,
      @required this.title,
      @required this.name,
      this.content});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      articleImageUrl: imageURL,
                      articleTitle: title,
                      articleContent: content,
                      articleSourceName: name,
                    )));
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black12, offset: Offset(0, 1), blurRadius: 6.0)
        ]),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: Text(
                          title,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600,
                              wordSpacing: 2.5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                      flex: 4,
                      child: Container(
                        child: Align(
                            alignment: Alignment.center,
                            child: Image.network(imageURL)),
                      )),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.bookmark,
                    color: Colors.black12,
                  ),
                  Text(
                    name,
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Below is User Menu
class UserDrawer extends StatefulWidget {
  const UserDrawer({Key key}) : super(key: key);
  @override
  _UserDrawerState createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  List<CategoryModel> categories = List<CategoryModel>();

  @override
  Widget build(BuildContext context) {
    //Here we get the category provider and we modify the value of the category and notify listeners
    final CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context);
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(child: Text('User Menu')),
          ListTile(
            title: Text('Business'),
            onTap: () {
              categoryProvider.setCategory('Business');

              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text('Entertainment'),
            onTap: () {

              categoryProvider.setCategory('Entertainment');

              Navigator.of(context).pop();
            },
          ),
          ListTile(
              title: Text('General'),
              onTap: () {
                categoryProvider.setCategory('General');
                Navigator.of(context).pop();
              }),
          ListTile(
              title: Text('Health'),
              onTap: () {
                categoryProvider.setCategory('Health');

                Navigator.of(context).pop();
              }),
          ListTile(
              title: Text('Science'),
              onTap: () {
                categoryProvider.setCategory('Science');

                Navigator.of(context).pop();
              }),
          ListTile(
              title: Text('Sports'),
              onTap: () {
                categoryProvider.setCategory('Sports');

                Navigator.of(context).pop();
              }),
          ListTile(
              title: Text('Technology'),
              onTap: () {
                categoryProvider.setCategory('Technology');

                Navigator.of(context).pop();
              }),
          ListTile(
              title: Text('Setting'),
              onTap: () {
                Navigator.pushNamed(context, SettingScreen.id);
              })
        ],
      ),
    );
  }
}

//Drawer(
//child: ListView(
//children: <Widget>[
//DrawerHeader(child: Text('User Menu')),
//ListTile(
//title: Text('Business'),
//),
//ListTile(
//title: Text('Entertainment'),
//onTap: () {
//Navigator.pushNamed(context, WelcomeScreen.id);
//},
//),
//ListTile(
//title: Text('General'),
//),
//ListTile(
//title: Text('Health'),
//),
//ListTile(
//title: Text('Tech & Science'),
//),
//ListTile(
//title: Text('Sport'),
//),
//],
//),
//);
