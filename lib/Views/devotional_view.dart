import 'package:flutter/material.dart';

import '../Util/Globals.dart';

class DevotionalView extends StatefulWidget {
  const DevotionalView({Key key, this.data}) : super(key: key);

  final dynamic data;

  @override
  _DevotionalViewState createState() => _DevotionalViewState();
}

class _DevotionalViewState extends State<DevotionalView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devotional'),
        backgroundColor: Globals.getPrimaryColor(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network("https://admin.feedthehungerapp.com/api/devotionals/" + widget.data["ResourceId"] + "/" + widget.data["ResourcePosition"] + ".jpg"),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(widget.data["Title"],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 14),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("by " + widget.data["Author"],
                          style: TextStyle(
                            fontSize: 14,
                          )
                        ),
                      ),
                    ),
                    Text(widget.data["Content"],
                      style: TextStyle(
                        fontSize: 18,
                      )
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
