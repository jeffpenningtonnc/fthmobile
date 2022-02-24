import 'package:flutter/material.dart';
import '../Widget/header.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'step_view.dart';

class EventView extends StatefulWidget {
  const EventView({Key key, this.drawerKey, this.data}) : super(key: key);

  final GlobalKey<ScaffoldState> drawerKey;

  final dynamic data;

  @override
  _EventViewState createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Header(widget.key, widget.drawerKey),
        const SizedBox(height: 15),
        SizedBox(
            height: 35,
            width: double.infinity,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 142, 197, 95),
              ),
              child: Center(
                child: Text(
                  widget.data["Name"],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            )),
        Container(color: const Color.fromARGB(255, 230, 230, 230), height: 20),
        Expanded(
          child: Container(
            color: const Color.fromARGB(255, 230, 230, 230),
            child: Column(
              children: <Widget>[
                TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: 0.05,
                  isFirst: true,
                  indicatorStyle: const IndicatorStyle(
                    width: 20,
                    color: Colors.lightGreen,
                    padding: EdgeInsets.all(6),
                  ),
                  endChild: _RightChild(
                    drawerKey: widget.drawerKey,
                    asset: "images/status/packing.png",
                    title: 'Packing',
                    message: 'Upcoming or in progress',
                  ),
                  beforeLineStyle: const LineStyle(
                    color: Colors.lightGreen,
                  ),
                ),
                TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: 0.05,
                  indicatorStyle: const IndicatorStyle(
                    width: 20,
                    color: Colors.lightGreen,
                    padding: EdgeInsets.all(6),
                  ),
                  endChild: const _RightChild(
                    asset:
                        'images/status/warehouse.png',
                    title: 'Warehouse',
                    message: 'Loading trucks for delivery',
                  ),
                  beforeLineStyle: const LineStyle(
                    color: Colors.lightGreen,
                  ),
                ),
                TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: 0.05,
                  indicatorStyle: const IndicatorStyle(
                    width: 20,
                    color: Colors.amber,
                    padding: EdgeInsets.all(6),
                  ),
                  endChild: const _RightChild(
                    asset:
                        'images/status/shipping.png',
                    title: 'Shipping',
                    message: 'Transporting to destination',
                  ),
                  beforeLineStyle: const LineStyle(
                    color: Colors.lightGreen,
                  ),
                  afterLineStyle: const LineStyle(
                    color: Colors.black26,
                  ),
                ),
                TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: 0.05,
                  isLast: true,
                  indicatorStyle: const IndicatorStyle(
                    width: 20,
                    color: Colors.black26,
                    padding: EdgeInsets.all(6),
                  ),
                  endChild: const _RightChild(
                    disabled: true,
                    asset:
                        'images/status/complete.png',
                    title: 'Complete',
                    message: 'Food has been delivered',
                  ),
                  beforeLineStyle: const LineStyle(
                    color: Colors.black26,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

class _RightChild extends StatelessWidget {

  const _RightChild({
    Key key,
    this.drawerKey,
    this.asset,
    this.title,
    this.message,
    this.disabled = false,
  }) : super(key: key);

  final GlobalKey drawerKey;
  final String asset;
  final String title;
  final String message;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: Card(
        margin: const EdgeInsets.fromLTRB(5, 0, 20, 0),
        color: Colors.white,
        child: ListTile(
            contentPadding: const EdgeInsets.fromLTRB(8, 2, 6, 0),
            leading: Opacity(
              child: Image(
                image: AssetImage(asset),
                width: 60,
              ),
              opacity: disabled ? 0.5 : 1,
            ),
            title: Opacity(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                opacity: disabled ? 0.5 : 1),
            subtitle: Opacity(
              child: Text(
                message,
                style: const TextStyle(color: Colors.black),
              ),
              opacity: disabled ? 0.5 : 1,
            ),
        ),
      ),
    );
  }
}
