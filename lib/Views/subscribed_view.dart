import 'package:flutter/material.dart';
import '../Services/account_service.dart';
import '../Services/event_service.dart';
import '../Util/globals.dart';
import 'event_view.dart';
import 'subscribe_view.dart';
import '../Widget/title_bar.dart';
import '../Widget/white_spinner.dart';

class SubscribedView extends StatefulWidget {
  const SubscribedView({Key key, this.drawerKey}) : super(key: key);

  final GlobalKey<ScaffoldState> drawerKey;

  @override
  _SubscribedViewState createState() => _SubscribedViewState();
}

class _SubscribedViewState extends State<SubscribedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TitleBar(widget.key, "Events Following"),
          Container(
            height: 5,
            color: Colors.black,
          ),
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: const Center(
              child: Text("(Coming EOD)")
            ),
          ))
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   icon: const Icon(Icons.add),
      //   label: const Text('Follow Event'),
      //   backgroundColor: const Color.fromARGB(255, 142, 197, 95),
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => const SubscribeView()),
      //     );
      //   },
      // ),
    );
  }
}
