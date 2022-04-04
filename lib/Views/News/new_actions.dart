import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fthmobile/Services/account_service.dart';
import 'package:fthmobile/Services/news_service.dart';
import 'package:fthmobile/Util/Globals.dart';
import 'package:fthmobile/Util/time.dart';
import 'package:fthmobile/Views/News/like_news.dart';

class NewsActions extends StatefulWidget {
  const NewsActions({Key key, this.data}) : super(key: key);

  final dynamic data;

  @override
  _NewsActionsState createState() => _NewsActionsState();
}

class _NewsActionsState extends State<NewsActions> {
  TextEditingController commentsController = TextEditingController();
  dynamic comments = [];

  @override
  void dispose() {
    commentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    int numComments = int.parse(widget.data["comments"]);

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Column(
        children: [
          Container(
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
                  LikeNews(data: widget.data),
                  GestureDetector(
                      child: SizedBox(
                        height: 30,
                        child: Row(
                          children: [
                            const Icon(Icons.comment, color: Colors.grey),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                              child: Text(numComments == 0 ? "Comments" : "Comments (" + numComments.toString() + ")",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      onTap: () async {

                        dynamic _comments = await NewsService.getComments(int.parse(widget.data["EventResourceId"]));

                        setState(() {
                          comments = _comments;
                        });
                      }
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1,
                    color: Colors.black26,
                  ),
                ),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics:const NeverScrollableScrollPhysics(),
            itemCount: comments.length,
            itemBuilder: (context, index) {
              dynamic data = comments[index];
              String dt = TimeAgo.timeAgoSinceDate(data["Created"]);

              return Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Colors.black12,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      child: ClipOval(
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.network("https://admin.feedthehungerapp.com/api/profile/profile_" + data["UserId"] + ".png",
                            errorBuilder: (BuildContext errContext, Object exception, StackTrace stackTrace) {
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
                            },
                          ),
                        ),
                      ),
                      backgroundColor: Colors.transparent,
                      radius: 24,
                    ),
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(4, 14, 0, 14),
                        child: Column(

                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(data["Firstname"] + " " + data["Lastname"],
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text("  " + dt,
                                        style: const TextStyle(
                                            fontSize: 13
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Text(data["Comment"],
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 36,
                    child: TextField(
                      controller: commentsController,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(14, 0, 0, 0),
                        hintText: "Comment",
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black26, width: 1, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Globals.getPrimaryColor(), width: 2, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {

                    String comment = commentsController.text;
                    if (comment.isEmpty) {
                      return;
                    }

                    await NewsService.addComment(int.parse(widget.data["EventResourceId"]), comment);
                    setState(() {
                      commentsController.text = "";
                    });

                    dynamic _comments = await NewsService.getComments(int.parse(widget.data["EventResourceId"]));
                    setState(() {
                      comments = _comments;
                    });

                  },
                  icon: Icon(Icons.send,
                    color: Globals.getPrimaryColor(),
                  ),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}
