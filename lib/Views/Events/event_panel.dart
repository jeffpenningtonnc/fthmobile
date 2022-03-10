import 'package:flutter/material.dart';
import 'event_view.dart';

class EventsPanel extends StatefulWidget {
  const EventsPanel(Key key, this.events) : super(key: key);

  final dynamic events;

  @override
  _EventsPanelState createState() => _EventsPanelState();
}

class _EventsPanelState extends State<EventsPanel> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.events.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(43, 1, 1, 1),
          child: Card(
            color: const Color.fromARGB(255, 245, 245, 245),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(

                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.event,
                      size: 14,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                        widget.events[index]["Name"],
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                    ),
                    const Icon(
                      Icons.arrow_right,
                      size: 14
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EventView(data: widget.events[index])),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
