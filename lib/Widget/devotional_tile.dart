import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fthmobile/Views/devotional_view.dart';
import 'package:fthmobile/Widget/spinner.dart';
import 'package:intl/intl.dart';

import '../Services/library_service.dart';

class DevotionalTile extends StatefulWidget {
  const DevotionalTile({Key key, this.setPage}) : super(key: key);

  final Function(int) setPage;

  @override
  _DevotionalTileState createState() => _DevotionalTileState();
}

class _DevotionalTileState extends State<DevotionalTile> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LibraryService.getDevotionals(),
      builder: (context, response) {

        if (response.connectionState == ConnectionState.waiting) {
          return Container();
        }

        dynamic data = {};
        int day = 0;

        bool hasDevotionals = true;
        if (response.data != null && response.data.length > 0) {
          data = response.data[0];

          DateTime subscriptionDate = DateFormat("yyyy-MM-dd H:mm:ss").parse(data["SubscriptionDate"]);
          final today = DateTime.now();
          final diff = today.difference(subscriptionDate);
          day = diff.inDays + 1;

          if (day > 30)
          {
            double f = day / 30;
            int d = f.truncate();
            day = day - (d * 30);
          }
        }
        else {
          hasDevotionals = false;
        }

        return hasDevotionals ? InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DevotionalView(data: data),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 110,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                        ),
                        image: DecorationImage(
                          image: NetworkImage("https://admin.feedthehungerapp.com/api/devotionals/" + data["ResourceId"] + "/" + day.toString() + "_small.jpg"),
                          fit: BoxFit.fill,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 2, 0, 6),
                            child: Text(data["Title"],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )),
                          ),
                        ),
                        Text(data["Intro"]),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text("Read Devotional >",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ) : InkWell(
          onTap: () {
            widget.setPage(3);
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      constraints: const BoxConstraints(
                        minWidth: 115,
                        minHeight: 115,
                        maxWidth: 115,
                        maxHeight: 115,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("images/devotions.png"),
                      ),
                    ),
                    Container(
                      child: Flexible(
                        child: Column(
                          children: const [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
                                child: Text("Daily Devotions",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    )
                                ),
                              ),
                            ),
                            Text(
                              "Subscribe to receive 30 days of devotions right here within the Feed The Hunger App.",
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Subscribe Now >",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ]
              ),
            )
          ),
        );
      },
    );
  }
}
