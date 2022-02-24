import 'dart:developer';

import 'package:flutter/material.dart';
import '../Util/globals.dart';
import '../Widget/title_bar.dart';
import 'add_news.dart';

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
          TitleBar(widget.key, "News Feed"),
          Expanded(
              child: Container(
                  color: Color.fromARGB(255, 230, 230, 230),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: <Widget>[
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 12, 0, 8),
                            child: ListTile(
                                title: Image.network(
                                    "https://pbs.twimg.com/media/DkHTw8bX0AAZIae.jpg"),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 8,
                                    ),
                                    const Text(
                                      "3/4/2020 - Posted by: Admin",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text("Having a great time!"),
                                  ],
                                )),
                          ),
                        ),
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 12, 0, 8),
                            child: ListTile(
                                title: Image.network(
                                    "https://ethicalfocus.org/wp-content/uploads/2018/11/Packathon-1.jpg"),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 8,
                                    ),
                                    const Text(
                                      "3/6/2020 - Posted by: Admin",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text("For all ages!"),
                                  ],
                                )),
                          ),
                        ),
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 12, 0, 8),
                            child: ListTile(
                                title: const Icon(Icons.chat_bubble,
                                    color: Colors.blue),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 8,
                                    ),
                                    const Text(
                                      "3/6/2020 - Posted by: Admin",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                        "We packed a lot of boxes today. Thanks everyone or your hard work!"),
                                  ],
                                )),
                          ),
                        ),
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 12, 0, 8),
                            child: ListTile(
                                title: Image.network(
                                    "https://christchurchgreenwich.org/wp-content/uploads/2020/06/packathon-enews.jpg"),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 8,
                                    ),
                                    const Text(
                                      "3/7/2020 - Posted by: Admin",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                        "Working well together on the assembly line."),
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ))),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Add'),
        backgroundColor: Globals.getPrimaryColor(),
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNewsView(),
              ),
          ).then((value) {
            setState(() {
              log("TEST");
            });
          });

        },
      ),
    );
  }
}
