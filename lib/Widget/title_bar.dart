import 'package:flutter/material.dart';

import '../Util/globals.dart';

class TitleBar extends StatelessWidget {
  const TitleBar(Key key, this._title) : super(key: key);
  final String _title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
            height: 35,
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Globals.getPrimaryColor(),
              ),
              child: Center(
                child: Text(
                  _title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white
                  ),
                ),
              ),
            )
        ),
      ],
    );
  }
}
