import 'package:flutter/material.dart';
import 'package:douban_movie_flutter/widget/dotted_line_widget.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          print('dianle');
        },
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(14),
                child: Row(
                  children: <Widget>[
                    Text('热度：333333334',
                        style: new TextStyle(color: new Color(3333333333))),
                    SizedBox(width: 10),
                    _buildMovieInfo(context),
                    SizedBox(width: 10),
                    _buildDottedLine(),
                    SizedBox(width: 10),
                    new Text('片源')
                  ],
                )),
            Divider(height: 1)
          ],
        ));
  }
}

Widget _buildMovieInfo(BuildContext context) {
  return Expanded(child: Text('龙岭迷窟', style: new TextStyle(fontSize: 20.0)));
}

Widget _buildDottedLine() {
  return Container(
    height: 100,
    child: Center(
      child: DottledLine(
          length: 100, spacing: 6, orientation: orientationVertical),
    ),
  );
}
