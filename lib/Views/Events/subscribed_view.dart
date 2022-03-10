import 'package:flutter/material.dart';
import 'package:fthmobile/Common/spinner.dart';
import 'package:fthmobile/Common/title_bar.dart';
import 'package:fthmobile/Services/account_service.dart';
import 'package:fthmobile/Services/event_service.dart';
import 'package:fthmobile/Util/globals.dart';
import 'package:fthmobile/Views/Events/event_view.dart';
import 'package:fthmobile/Views/Events/subscribe_view.dart';

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
      body: Container(
        child: Column(
          children: <Widget>[
            const TitleBar(title: "Organizations Following"),
            Expanded(
                child: Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(backgroundLocation),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: FutureBuilder(
                    future: EventService.getSubscribedOrganizations(
                        AccountService.userId),
                    builder: (context, response) {
                      if (response.connectionState == ConnectionState.waiting) {
                        return const Spinner();
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
                              padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                              child: Card(
                                  color: Colors.white,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EventView(
                                                data: data)),
                                      );
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        ListTile(
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  10, 0, 0, 0),
                                          leading: Container(
                                            constraints: const BoxConstraints(
                                              minWidth: 85,
                                              minHeight: 70,
                                              maxWidth: 85,
                                              maxHeight: 70,
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                image: DecorationImage(
                                                  image: NetworkImage(url),
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                          title: Text(
                                            data["Name"],
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            data["City"] + ", " + data["State"],
                                            style: const TextStyle(
                                              color: Colors.black,
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
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Follow Organization'),
        backgroundColor: const Color.fromARGB(255, 142, 197, 95),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SubscribeView()),
          ).then((value) {
            setState(() {

            });
          });
        },
      ),
    );
  }
}
