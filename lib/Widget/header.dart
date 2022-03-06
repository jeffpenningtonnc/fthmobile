import 'package:flutter/material.dart';
import 'package:fthmobile/Util/globals.dart';

class Header extends StatefulWidget {
  const Header({Key key}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            iconSize: 32,
            color: Colors.black,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          // Visibility(
          //   visible: widget.drawerKey == null,
          //   child: Column(
          //     children: <Widget>[
          //       const SizedBox(
          //         height: 30
          //       ),
          //       IconButton(
          //         icon: const Icon(Icons.arrow_back_ios),
          //         iconSize: 24,
          //         color: Colors.black,
          //         onPressed: () {
          //           Navigator.pop(context, true);
          //         },
          //       ),
          //     ],
          //   ),
          // ),
          Column(
            children: <Widget>[
              const SizedBox(height: 40),
              Center(
                child: Image.asset(
                  logoLocation,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          const Icon(
            Icons.navigate_before,
            size: 40,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
