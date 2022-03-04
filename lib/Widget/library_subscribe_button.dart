import 'dart:developer';

import 'package:flutter/material.dart';

import '../Services/library_service.dart';
import '../Util/Globals.dart';

class LibrarySubscribeButton extends StatefulWidget {
  const LibrarySubscribeButton({Key key, this.data}) : super(key: key);

  final dynamic data;

  @override
  _LibrarySubscribeButtonState createState() => _LibrarySubscribeButtonState();
}

class _LibrarySubscribeButtonState extends State<LibrarySubscribeButton> {
  bool isSubscribable = false;
  bool isSubscribed = false;

  @override
  void initState() {
    isSubscribable = widget.data["Subscribable"] == "1";
    isSubscribed = widget.data["UserSubscriptionId"] != null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isSubscribable,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
          child: GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                color: isSubscribed ? Globals.getPrimaryColor() : Colors.yellow,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.all(4),
              child: Text(
                isSubscribed ? "Subscribed" : "Subscribe",
                style: TextStyle(
                  color: isSubscribed ? Colors.white : Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
            onTap: () {

              if (isSubscribed) {
                LibraryService.unsubscribe(widget.data["ResourceId"]);
                setState(() {
                  isSubscribed = false;
                });
              }
              else {
                LibraryService.subscribe(widget.data["ResourceId"]);
                setState(() {
                  isSubscribed = true;
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
