import 'package:flutter/material.dart';

class Spinner extends StatelessWidget {
  const Spinner({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.black45),
    );
  }
}
