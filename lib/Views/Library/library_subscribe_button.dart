import 'dart:developer';

import 'package:flutter/material.dart';
import '../../Services/library_service.dart';

class LibrarySubscribeButton extends StatefulWidget {
  const LibrarySubscribeButton({Key key, this.data}) : super(key: key);

  final dynamic data;

  @override
  _LibrarySubscribeButtonState createState() => _LibrarySubscribeButtonState();
}

class _LibrarySubscribeButtonState extends State<LibrarySubscribeButton> {
  bool isSubscribed = false;

  @override
  void initState() {
    isSubscribed = widget.data["UserSubscriptionId"] != null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      borderRadius: BorderRadius.circular(8),
      child: MaterialButton(
        child: isSubscribed
            ? const Text(
                "Unsubscribe",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              )
            : const Text(
                "Subscribed",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
        onPressed: () {
          if (isSubscribed) {
            LibraryService.unsubscribe(widget.data["ResourceId"]);
            setState(() {
              isSubscribed = false;
            });
          } else {
            LibraryService.subscribe(widget.data["ResourceId"]);
            setState(() {
              isSubscribed = true;
            });
          }
        },
      ),
    );
  }
}
