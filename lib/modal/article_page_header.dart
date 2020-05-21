import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/rendering.dart';

class ArticlePageHeader implements SliverPersistentHeaderDelegate {
  ArticlePageHeader(
      {this.minExtent, @required this.maxExtent, this.aImageUrl});

  final double minExtent;
  final double maxExtent;
  final String aImageUrl;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.network(
          aImageUrl,
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black54],
                stops: [0.5, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                tileMode: TileMode.repeated),
          ),
        ),
      ],
    );
  }

  double titleOpacity(double shrinkOffset) {
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
}
