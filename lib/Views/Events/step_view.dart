import 'package:flutter/material.dart';
import 'package:fthmobile/Common/header.dart';

class StepView extends StatefulWidget {
  const StepView(Key key) : super(key: key);

  @override
  _StepViewState createState() => _StepViewState();
}

class _StepViewState extends State<StepView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const Header(),
          const SizedBox(height: 15),
          const SizedBox(
              height: 35,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 142, 197, 95),
                ),
                child: Center(
                  child: Text(
                    "Photos & Videos",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              )),
          Expanded(
              child: Container(
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: <Widget>[
                        Card(
                            color: const Color.fromRGBO(220, 220, 220, 1),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 12, 0, 8),
                              child: ListTile(
                                  title: Image.network(
                                      "https://pbs.twimg.com/media/DkHTw8bX0AAZIae.jpg"),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height: 8,
                                      ),
                                      const Text(
                                        "3/4/2020 - Posted by: Admin",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text("Having a great time!"),
                                    ],
                                  )),
                            ),),
                        Card(
                            color: const Color.fromRGBO(220, 220, 220, 1),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 12, 0, 8),
                              child: ListTile(
                                  title: Image.network(
                                      "https://ethicalfocus.org/wp-content/uploads/2018/11/Packathon-1.jpg"),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height: 8,
                                      ),
                                      const Text(
                                        "3/6/2020 - Posted by: Admin",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text("For all ages!"),
                                    ],
                                  )),
                            ),),
                        Card(
                          color: const Color.fromRGBO(220, 220, 220, 1),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 12, 0, 8),
                            child: ListTile(
                              title: const Icon(Icons.chat_bubble, color: Colors.blue),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 8,
                                    ),
                                    const Text(
                                      "3/6/2020 - Posted by: Admin",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text("We packed a lot of boxes today. Thanks everyone or your hard work!"),
                                  ],
                                )),
                          ),),
                        Card(
                          color: const Color.fromRGBO(220, 220, 220, 1),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 12, 0, 8),
                            child: ListTile(
                                title: Image.network(
                                    "https://christchurchgreenwich.org/wp-content/uploads/2020/06/packathon-enews.jpg"),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 8,
                                    ),
                                    const Text(
                                      "3/7/2020 - Posted by: Admin",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text("Working well together on the assembly line."),
                                  ],
                                )),
                          ),),
                      ],
                    ),
                  ))),
        ],
      ),
    );
  }
}
