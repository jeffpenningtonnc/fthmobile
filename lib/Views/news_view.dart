import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '/Services/promotions_service.dart';
import '/Util/globals.dart';
import '/Widget/title_bar.dart';
import '/Widget/white_spinner.dart';

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
              color: Colors.black,
            ),
            Expanded(
                child: Container(
                  color: Colors.black,
                  child: Center(
                    child: FutureBuilder(
                        future: PromotionsService.getPromotions(),
                        builder: (context, response) {
                          if (response.connectionState == ConnectionState.waiting) {
                            return WhiteSpinner(widget.key);
                          }

                          if (response.data == null || response.data.length == 0) {
                            return const Text("No new announcements!");
                          }

                          return ListView.builder(
                              itemCount: response.data.length,
                              itemBuilder: (context, index) {
                                dynamic data = response.data[index];
                                String url = Globals.getResource(data["FileName"], 256);

                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(12,4,12,4),
                                  child: Card(
                                    color: const Color.fromRGBO(100, 100, 100, 100),
                                      child: ListTile (
                                        title: Image.network(url),
                                        onTap: () async {

                                          if (await canLaunch(data["ExternalUrl"])) {
                                            await launch(data["ExternalUrl"]);
                                          } else {
                                            throw 'Could not launch $url';
                                          }

                                        },
                                      )
                                  ),
                                );
                              }
                          );
                        }
                    ),
                  ),
                )
            )
          ],
        )
    );
  }
}


