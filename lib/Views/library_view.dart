import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Services/library_service.dart';
import '../Util/globals.dart';
import '../Widget/spinner.dart';
import '../Widget/title_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'library_manage_view.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({Key key, this.drawerKey, this.initialFilter})
      : super(key: key);

  final String initialFilter;
  final GlobalKey<ScaffoldState> drawerKey;

  @override
  _LibraryViewState createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  String dropdownValue = "All";

  @override
  void initState() {
    GlobalKey<ScaffoldState> drawerKey = widget.drawerKey;

    if (widget.initialFilter != null && widget.initialFilter.isNotEmpty) {
      dropdownValue = widget.initialFilter;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundLocation),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: <Widget>[
          TitleBar(widget.key, "Library"),
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton(
                  value: dropdownValue,
                  hint: const Text('Filter'),
                  icon: const Icon(Icons.arrow_drop_down),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>['All', 'Devotionals']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LibraryManageView()),
                    );
                  },
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
                        child: Icon(Icons.settings),
                      ),
                      Text("Manage Subscriptions")
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                    future: LibraryService.getItems(
                        dropdownValue == "Devotionals" ? 1 : 0),
                    builder: (context, response) {
                      if (response.connectionState == ConnectionState.waiting) {
                        return const Spinner();
                      }
                      if (response.data == null || response.data.length == 0) {
                        return const Text("Library empty");
                      }

                      return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 30,
                          ),
                          itemCount: response.data.length,
                          shrinkWrap: false,
                          itemBuilder: (context, index) {
                            dynamic data = response.data[index];
                            String url =
                                "https://admin.feedthehungerapp.com/api/uploads/" +
                                    data["ThumbFileName"] +
                                    "_128";

                            return ListTile(
                              title: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6),
                                        image: DecorationImage(
                                          image: NetworkImage(url),
                                          fit: BoxFit.fill,
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromARGB(40, 0, 0, 0),
                                            offset: Offset(
                                              6.0,
                                              6.0,
                                            ),
                                          )
                                        ]),
                                  ),
                                  data["Subscribable"] == "1" &&
                                          data["UserSubscriptionId"] == null
                                      ? Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                4, 0, 4, 12),
                                            child: GestureDetector(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.yellow,
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(4),
                                                child: const Text(
                                                  "Subscribe",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              onTap: () {},
                                            ),
                                          ),
                                        )
                                      : data["Subscribable"] == "1" &&
                                              data["UserSubscriptionId"] != null
                                          ? Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        4, 0, 4, 12),
                                                child: GestureDetector(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(4),
                                                      color: Globals.getPrimaryColor(),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    child: const Text(
                                                      "Subscribed",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {},
                                                ),
                                              ),
                                            )
                                          : Container()
                                ],
                              ),
                              onTap: () async {
                                await launch(
                                    "https://admin.feedthehungerapp.com/api/uploads/" +
                                        data["FileName"]);
                              },
                            );
                          });
                    }),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
