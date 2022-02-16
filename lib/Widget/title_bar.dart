import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  const TitleBar(Key key, this._title) : super(key: key);
  final String _title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
            height: 5
        ),
        SizedBox(
            height: 35,
            width: double.infinity,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 142, 197, 95),
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
