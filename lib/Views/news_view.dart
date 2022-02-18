import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Services/promotions_service.dart';
import '../Util/globals.dart';
import '../Widget/title_bar.dart';
import '../Widget/white_spinner.dart';

class NewsView extends StatefulWidget {
  const NewsView({Key key, this.drawerKey}) : super(key: key);

  final GlobalKey<ScaffoldState> drawerKey;

  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            TitleBar(widget.key, "News"),
            Container(
              height: 5,
              color: Colors.white,
            ),
            Expanded(
                child: Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text("(Coming EOD)"
                    ),
                  ),
                )
            )
          ],
        )
    );
  }
}


