import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:fthmobile/Common/title_bar.dart';
import 'package:fthmobile/Services/account_service.dart';
import 'package:fthmobile/Services/news_service.dart';
import 'package:fthmobile/Util/Globals.dart';
import 'package:fthmobile/Views/News/add_news.dart';
import 'package:fthmobile/Views/News/like_news.dart';
import 'package:intl/intl.dart';

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
          const TitleBar(title: "News Feed"),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
              color: const Color.fromARGB(255, 230, 230, 230),
              child: FutureBuilder(
                future: NewsService.getItems(),
                builder: (context, response) {
                  if (response.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black)));
                  }

                  return RefreshIndicator(
                    color: Colors.black,
                    child: ListView.builder(
                      itemCount: response.data.length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        dynamic data = response.data[index];

                        String dt = TimeAgo.timeAgoSinceDate(data["UploadDate"]);

                        String url = "";
                        String filename = data["FileName"];

                        if (filename != null && filename.isNotEmpty) {
                          url = "https://admin.feedthehungerapp.com/api/uploads/" + filename + "_512";
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        child: ClipOval(
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            child: ExtendedImage.network("https://admin.feedthehungerapp.com/api/profile/profile_" + data["UserId"] + ".png",
                                              cache: true,
                                              loadStateChanged: (ExtendedImageState state) {
                                                switch (state.extendedImageLoadState) {
                                                  case LoadState.failed:
                                                    return CircleAvatar(
                                                      child: Text(
                                                        AccountService.getInitialsFromText(data["Firstname"], data["Lastname"]),
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      radius: 24,
                                                      backgroundColor: Globals.getPrimaryColor(),
                                                    );
                                                  case LoadState.completed:
                                                    return CircleAvatar(
                                                      backgroundColor: Colors.white,
                                                      backgroundImage: NetworkImage("https://admin.feedthehungerapp.com/api/profile/profile_" + data["UserId"] + ".png"),
                                                    );
                                                }
                                                return Container();
                                              },
                                            ),
                                          ),
                                        ),
                                        backgroundColor: Colors.transparent,
                                        radius: 24,
                                      ),
                                      Container(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        data["Firstname"] + " " + data["Lastname"],
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text("  " + dt),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                                                child: Text(
                                                    data["Organization"]
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          child: const Padding(
                                            padding: EdgeInsets.all(12.0),
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: Icon(Icons.keyboard_arrow_down,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          onTapDown: (TapDownDetails details) {
                                            Offset offset = details.globalPosition;

                                            showMenu(
                                              context: context,
                                              elevation: 8.0,
                                              position: RelativeRect.fromLTRB(offset.dx, offset.dy - 18, 20, 0),
                                              items: [
                                                PopupMenuItem(
                                                  padding: const EdgeInsets.fromLTRB(12, 2, 0, 4),
                                                  height: 14,
                                                  value: 1,
                                                  enabled: false,
                                                  child: Row(
                                                    children: [
                                                      const Icon(Icons.edit),
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                                                        child: Text("Edit",
                                                          textScaleFactor: MediaQuery.of(context).textScaleFactor,
                                                        ),
                                                      ),
                                                    ],
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  padding: const EdgeInsets.fromLTRB(12, 4, 0, 2),
                                                  height: 14,
                                                  value: 1,
                                                  child: Row(
                                                    children: [
                                                      const Icon(Icons.delete_rounded),
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                                                        child: Text("Delete",
                                                          textScaleFactor: MediaQuery.of(context).textScaleFactor,
                                                        ),
                                                      ),
                                                    ],
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                  ),
                                                  onTap: () {
                                                    Future<void>.delayed(
                                                      const Duration(),
                                                      // OR const Duration(milliseconds: 500),
                                                      () => showDialog(
                                                        context: context,
                                                        barrierDismissible: true,
                                                        barrierColor: Colors.black26,
                                                        builder: (context) => AlertDialog(
                                                          title: const Text("Delete Post"),
                                                          content: const Text("Are you sure you wish to delete this post?"),
                                                          actions: [
                                                            OutlinedButton(
                                                              style: OutlinedButton.styleFrom(
                                                                primary: Colors.black,
                                                                backgroundColor: Colors.white,
                                                                side: const BorderSide(color: Colors.grey, width: 1),
                                                              ),
                                                              child: const Text("Cancel"),
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                              },
                                                            ),
                                                            MaterialButton(
                                                              color: Colors.red,
                                                              child: const Text("Delete",
                                                                  style: TextStyle(
                                                                    color: Colors.white,
                                                                  )),
                                                              onPressed: () async {
                                                                Navigator.of(context).pop();

                                                                await NewsService.deleteItem(data["EventResourceId"]);
                                                                setState(() {});
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  url.isNotEmpty
                                      ? Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                          child: CachedNetworkImage(
                                            imageUrl: url,
                                            fit: BoxFit.fill,
                                          ),
                                        )
                                      : Container(),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
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
                                            LikeNews(data: data),
                                            Row(
                                              children: const [
                                                Icon(Icons.comment, color: Colors.grey),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                                                  child: Text("Comment",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.grey,
                                                      )),
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

            });
          });
        },
      ),
    );
  }
}

class TimeAgo {
  static String timeAgoSinceDate(String dateString, {bool numericDates = true}) {
    log(dateString);

    //return "";

    DateTime notificationDate = DateFormat("yyyy-MM-dd H:mm:ss").parse(dateString);
    notificationDate = notificationDate.add(const Duration(hours: 1));

    final date2 = DateTime.now();

    final difference = date2.difference(notificationDate);
    String formattedDate = DateFormat("M/d/yyyy").format(notificationDate);

    if (difference.inDays > 8) {
      return formattedDate;
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
