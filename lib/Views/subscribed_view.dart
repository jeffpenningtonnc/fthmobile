import 'package:flutter/material.dart';
import '/Services/account_service.dart';
import '/Services/event_service.dart';
import '/Util/globals.dart';
import '/Views/event_view.dart';
import '/Views/subscribe_view.dart';
import '/Widget/title_bar.dart';
import '/Widget/white_spinner.dart';

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
              color: Colors.black,
            ),
            child: Center(
              child: Container(
                color: Colors.black,
                child: FutureBuilder(
                    future: EventService.getSubscribedOrganizations(
                        AccountService.userId),
                    builder: (context, response) {
                      if (response.connectionState == ConnectionState.waiting) {
                        return WhiteSpinner(widget.key);
                      }
                      if (response.data == null || response.data.length == 0) {
                        return const Text("No events followed");
                      }

                      return ListView.builder(
                          itemCount: response.data.length,
                          shrinkWrap: false,
                          itemBuilder: (context, index) {
                            dynamic data = response.data[index];
                            String url =
                                Globals.getResource(data["FileName"], 256);

                            return Padding(
                              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                              child: Card(
                                  color: Colors.white24,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => EventView(data: data['Events'][0])),
                                      );
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        ListTile(
                                          leading: ConstrainedBox(
                                            constraints: const BoxConstraints(
                                              minWidth: 85,
                                              minHeight: 70,
                                              maxWidth: 85,
                                              maxHeight: 70,
                                            ),
                                            child: Image.network(url,
                                                fit: BoxFit.cover),
                                          ),
                                          title: Text(
                                            data["Name"],
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            data["City"] + ", " + data["State"],
                                            style: const TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ),
                                        //EventsPanel(data['Events']),
                                      ],
                                    ),
                                  )),
                            );
                          });
                    }),
              ),
            ),
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Follow Event'),
        backgroundColor: const Color.fromARGB(255, 142, 197, 95),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SubscribeView()),
          );
        },
      ),
    );
  }
}
