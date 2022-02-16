import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Util/globals.dart';
import '../Widget/title_bar.dart';

class DonateView extends StatefulWidget {
  const DonateView({Key key, this.drawerKey}) : super(key: key);

  final GlobalKey<ScaffoldState> drawerKey;

  @override
  _DonateViewState createState() => _DonateViewState();
}

class _DonateViewState extends State<DonateView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TitleBar(widget.key, "How to Donate"),
          Image.network("https://fth.jeffpenningtonnc.com/images/donate.png"),
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Html(
                backgroundColor: Colors.black,
                defaultTextStyle: const TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                ),
                data: Globals.getDonationContent()
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(8.0),
                    color: const Color.fromARGB(255, 142, 197, 95),
                    child: MaterialButton(
                      minWidth: (MediaQuery.of(context).size.width) / 2,
                      padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                      onPressed: () async {

                        var url = Globals.getDonationsUrl();

                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }

                      },
                      child: const Text(
                        "Donate Now",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}


