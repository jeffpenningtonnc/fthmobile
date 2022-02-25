import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Services/news_service.dart';
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
              padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
              color: const Color.fromARGB(255, 230, 230, 230),
              child: FutureBuilder(
                future: NewsService.getItems(),
                builder: (context, response) {

                  return RefreshIndicator(
                    color: Colors.black,
                    child: ListView.builder(
                      itemCount: response.data.length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        dynamic data = response.data[index];

                        String dt = DateFormat.yMMMEd()
                            .format(DateTime.parse(data["UploadDate"]));

                        String url = "";
                        String filename = data["FileName"];

                        if (filename != null && filename.isNotEmpty) {
                          url =
                              "https://admin.feedthehungerapp.com/api/uploads/" +
                                  filename + "_256";
                        }

                        return Padding(
                          padding: const EdgeInsets.fromLTRB(8, 1, 8, 1),
                          child: url.isNotEmpty ? Card(
                            color: Colors.white,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Image.network(
                                      url,
                                      fit: BoxFit.fill,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 4),
                                      child: Text(
                                        dt + " - " + data["Firstname"] + " " + data["Lastname"],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(data["Description"])
                                  ],
                                )),
                          ) : Card(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.chat,
                                        color: Colors.deepOrangeAccent,
                                      ),
                                      Container(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                                                child: Text(
                                                  dt + " - " + data["Firstname"] + " " + data["Lastname"],
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],

                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                                    child: Text(data["Description"]),
                                  )
                                ],
                              ),

                            ),

                          )
                        );
                      },
                    ),
                    onRefresh: () {
                      return Future.delayed(
                        const Duration(seconds: 1),
                        () {
                          setState(() {

                          });
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
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
