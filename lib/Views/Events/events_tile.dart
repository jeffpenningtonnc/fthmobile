import 'package:flutter/material.dart';

class EventsTile extends StatelessWidget {
  const EventsTile(Key key, this.data) : super(key: key);
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return const Text("test");
        }
    );
  }
}
