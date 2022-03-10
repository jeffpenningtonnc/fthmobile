import 'package:flutter/material.dart';

class WhiteSpinner extends StatelessWidget {
  const WhiteSpinner(Key key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
      ),
    );
  }
}
