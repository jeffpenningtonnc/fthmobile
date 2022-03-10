import 'package:flutter/material.dart';
import 'package:fthmobile/Util/Globals.dart';
import 'package:timeline_tile/timeline_tile.dart';

class EventView extends StatefulWidget {
  const EventView({Key key, this.data}) : super(key: key);

  final dynamic data;

  @override
  _EventViewState createState() => _EventViewState();
}

class StepInfo {
  bool isFirst;
  bool isLast;
  String name;
  String description;
  String imagePath;
  bool disabled;
  Color indicatorColor;
  Color beforeColor;
  Color afterColor;

  StepInfo(this.isFirst, this.isLast, this.name, this.description, this.imagePath, this.disabled, this.indicatorColor, this.beforeColor, this.afterColor);
}

class _EventViewState extends State<EventView> {
  Widget createStep(int step) {
    int statusId = int.parse(widget.data["EventStatusTypeId"]);
    StepInfo stepInfo = getStepInfo(step, statusId);

    Widget w = TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.05,
      isFirst: stepInfo.isFirst,
      isLast: stepInfo.isLast,
      indicatorStyle: IndicatorStyle(
        width: 20,
        color: stepInfo.indicatorColor,
        padding: const EdgeInsets.all(6),
      ),
      endChild: _RightChild(
        asset: stepInfo.imagePath,
        title: stepInfo.name,
        message: stepInfo.description,
        disabled: stepInfo.disabled,
      ),
      beforeLineStyle: LineStyle(
        color: stepInfo.beforeColor,
      ),
      afterLineStyle: LineStyle(
        color: stepInfo.afterColor,
      ),
    );

    return w;
  }

  StepInfo getStepInfo(int step, int statusId) {
    if (step == 1) {
      Color indicatorColor = statusId == 0
          ? Colors.grey
          : statusId == 1
              ? Colors.amber
              : Colors.lightGreen;
      Color beforeColor = Colors.black;
      Color afterColor = statusId == 0
          ? Colors.grey
          : statusId == 1
              ? Colors.grey
              : Colors.lightGreen;
      return StepInfo(true, false, "Packing", "Upcoming or in progress", "images/status/packing.png", statusId < 1, indicatorColor, beforeColor, afterColor);
    } else if (step == 2) {
      Color indicatorColor = statusId == 0
          ? Colors.grey
          : statusId == 2
              ? Colors.amber
              : statusId < 2
                  ? Colors.grey
                  : Colors.lightGreen;
      Color beforeColor = statusId == 0
          ? Colors.grey
          : statusId >= 2
              ? Colors.lightGreen
              : Colors.grey;
      Color afterColor = statusId == 0
          ? Colors.grey
          : statusId > 2
              ? Colors.lightGreen
              : Colors.grey;
      return StepInfo(false, false, "Warehouse", "Loading trucks for delivery", "images/status/warehouse.png", statusId < 2, indicatorColor, beforeColor, afterColor);
    } else if (step == 3) {
      Color indicatorColor = statusId == 0
          ? Colors.grey
          : statusId == 3
              ? Colors.amber
              : statusId < 3
                  ? Colors.grey
                  : Colors.lightGreen;
      Color beforeColor = statusId == 0
          ? Colors.grey
          : statusId >= 3
              ? Colors.lightGreen
              : Colors.grey;
      Color afterColor = statusId == 0
          ? Colors.grey
          : statusId > 3
              ? Colors.lightGreen
              : Colors.grey;
      return StepInfo(false, false, "Shipping", "Transporting to destination", "images/status/shipping.png", statusId < 3, indicatorColor, beforeColor, afterColor);
    } else if (step == 4) {
      Color indicatorColor = statusId == 0
          ? Colors.grey
          : statusId == 4
              ? Colors.amber
              : statusId < 4
                  ? Colors.grey
                  : Colors.lightGreen;
      Color beforeColor = statusId == 0
          ? Colors.grey
          : statusId >= 4
              ? Colors.lightGreen
              : Colors.grey;
      Color afterColor = Colors.grey;
      return StepInfo(false, true, "Complete", "Food has been delivered", "images/status/complete.png", statusId < 4, indicatorColor, beforeColor, afterColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Event Status'),
            backgroundColor: Globals.getPrimaryColor(),
            centerTitle: true,
          ),
          body: Column(
            children: <Widget>[
              Container(
                color: Color.fromARGB(255, 230, 230, 230),
                height: 32,
              ),
              SizedBox(
                  height: 35,
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 230, 230, 230),
                    ),
                    child: Center(
                      child: Text(
                        widget.data["Name"],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.black),
                      ),
                    ),
                  )),
              Container(color: const Color.fromARGB(255, 230, 230, 230), height: 20),
              Expanded(
                child: Container(
                  color: const Color.fromARGB(255, 230, 230, 230),
                  child: Column(
                    children: <Widget>[
                      createStep(1),
                      createStep(2),
                      createStep(3),
                      createStep(4),
                      // TimelineTile(
                      //   alignment: TimelineAlign.manual,
                      //   lineXY: 0.05,
                      //   indicatorStyle: const IndicatorStyle(
                      //     width: 20,
                      //     color: Colors.lightGreen,
                      //     padding: EdgeInsets.all(6),
                      //   ),
                      //   endChild: const _RightChild(
                      //     asset:
                      //         'images/status/warehouse.png',
                      //     title: 'Warehouse',
                      //     message: 'Loading trucks for delivery',
                      //   ),
                      //   beforeLineStyle: const LineStyle(
                      //     color: Colors.lightGreen,
                      //   ),
                      // ),
                      // TimelineTile(
                      //   alignment: TimelineAlign.manual,
                      //   lineXY: 0.05,
                      //   indicatorStyle: const IndicatorStyle(
                      //     width: 20,
                      //     color: Colors.amber,
                      //     padding: EdgeInsets.all(6),
                      //   ),
                      //   endChild: const _RightChild(
                      //     asset:
                      //         'images/status/shipping.png',
                      //     title: 'Shipping',
                      //     message: 'Transporting to destination',
                      //   ),
                      //   beforeLineStyle: const LineStyle(
                      //     color: Colors.lightGreen,
                      //   ),
                      //   afterLineStyle: const LineStyle(
                      //     color: Colors.black26,
                      //   ),
                      // ),
                      // TimelineTile(
                      //   alignment: TimelineAlign.manual,
                      //   lineXY: 0.05,
                      //   isLast: true,
                      //   indicatorStyle: const IndicatorStyle(
                      //     width: 20,
                      //     color: Colors.black26,
                      //     padding: EdgeInsets.all(6),
                      //   ),
                      //   endChild: const _RightChild(
                      //     disabled: true,
                      //     asset:
                      //         'images/status/complete.png',
                      //     title: 'Complete',
                      //     message: 'Food has been delivered',
                      //   ),
                      //   beforeLineStyle: const LineStyle(
                      //     color: Colors.black26,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class _RightChild extends StatelessWidget {
  const _RightChild({
    Key key,
    this.asset,
    this.title,
    this.message,
    this.disabled = false,
  }) : super(key: key);

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
