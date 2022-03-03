import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Services/account_service.dart';
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
                  if (response.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black)));
                  }

                  return RefreshIndicator(
                    color: Colors.black,
                    child: ListView.builder(
                      itemCount: response.data.length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        dynamic data = response.data[index];

                        String dt =
                            TimeAgo.timeAgoSinceDate(data["UploadDate"]);

                        String url = "";
                        String filename = data["FileName"];

                        if (filename != null && filename.isNotEmpty) {
                          url =
                              "https://admin.feedthehungerapp.com/api/uploads/" +
                                  filename +
                                  "_512";
                        }

                        return Padding(
                          padding: const EdgeInsets.fromLTRB(8, 1, 8, 1),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.white38, width: 0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        child: Text(
                                          AccountService.getInitialsFromText(data["Firstname"], data["Lastname"]),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                        radius: 24,
                                        backgroundColor: Globals.getSecondaryColor(),
                                      ),
                                      Container(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 0, 0, 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 8, 0, 0),
                                                  child: Text(
                                                    data["Firstname"] +
                                                        " " +
                                                        data["Lastname"],
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 2, 0, 0),
                                                child: Text(dt),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          child: const Align(
                                            alignment: Alignment.topRight,
                                              child: Icon(Icons.keyboard_arrow_down,
                                                color: Colors.grey,
                                              ),
                                          ),
                                          onTap: () {
                                            // showDialog(
                                            //   context: context,
                                            //   barrierDismissible: true,
                                            //   builder: (_) => AlertDialog(
                                            //     title: Text("Edit Post"),
                                            //     content: Text("Test"),
                                            //   ),
                                            // );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  url.isNotEmpty ? Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                    child: Image.network(
                                      url,
                                      fit: BoxFit.fill,
                                    ),
                                  ) : Container(),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                    child: Text(data["Description"]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              width: 1,
                                              color: Colors.black26,
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              children: const [
                                                Icon(Icons.thumb_up_alt_outlined,
                                                    color: Colors.grey
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                                                  child: Text("Like",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.grey,
                                                      )
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: const [
                                                Icon(Icons.comment,
                                                    color: Colors.grey
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                                                  child: Text("Comment",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.grey,
                                                      )
                                                  ),
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    onRefresh: () {
                      return Future.delayed(
                        const Duration(seconds: 1),
                        () {
                          setState(() {});
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

class TimeAgo {
  static String timeAgoSinceDate(String dateString,
      {bool numericDates = true}) {
    log(dateString);

    //return "";

    DateTime notificationDate =
        DateFormat("yyyy-MM-dd H:mm:ss").parse(dateString);
    notificationDate = notificationDate.add(const Duration(hours: 1));

    final date2 = DateTime.now();

    final difference = date2.difference(notificationDate);

    if (difference.inDays > 8) {
      return dateString;
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }
}
