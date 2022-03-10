import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fthmobile/Common/spinner.dart';
import 'package:fthmobile/Common/title_bar.dart';
import 'package:fthmobile/Services/library_service.dart';
import 'package:fthmobile/Util/Globals.dart';
import 'package:fthmobile/Views/Library/library_manage_view.dart';
import 'package:url_launcher/url_launcher.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({Key key, this.drawerKey, this.initialFilter}) : super(key: key);

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
          const TitleBar(title: "Library"),
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton(
                  value: dropdownValue,
                  elevation: 16,
                  hint: const Text('Filter'),
                  icon: const Icon(Icons.arrow_drop_down),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>['All', 'Devotionals'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      ),
                    );
                  }).toList(),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LibraryManageView()),
                    ).then((value) {
                      setState(() {

                      });
                    });
                  },
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
                        child: Icon(Icons.settings),
                      ),
                      Text("Subscriptions")
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 20, 0),
                child: FutureBuilder(
                    future: LibraryService.getItems(dropdownValue == "Devotionals" ? 1 : 0),
                    builder: (context, response) {
                      if (response.connectionState == ConnectionState.waiting) {
                        return const Spinner();
                      }
                      if (response.data == null || response.data.length == 0) {
                        return const Text("Library empty");
                      }

                      return GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 30,
                            crossAxisSpacing: 20,
                            childAspectRatio: .75,
                          ),
                          itemCount: response.data.length,
                          shrinkWrap: false,
                          itemBuilder: (context, index) {
                            dynamic data = response.data[index];
                            String url = "https://admin.feedthehungerapp.com/api/uploads/" + data["ThumbFileName"] + "_256";
                            bool isSubscribed = data["UserSubscriptionId"] != null;

                            return Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromARGB(40, 0, 0, 0),
                                          offset: Offset(
                                            8.0,
                                            8.0,
                                          ),
                                        )
                                      ],
                                    ),
                                    child: GestureDetector(
                                      child: ClipRRect(
                                        child: Image.network(
                                          url,
                                          filterQuality: FilterQuality.high,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      onTap: () async {
                                        await launch("https://admin.feedthehungerapp.com/api/uploads/" + data["FileName"]);
                                      },
                                    ),
                                  ),
                                ),
                                isSubscribed
                                    ? Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 10, 32, 0),
                                          child: CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Globals.getPrimaryColor(),
                                            child: const Icon(
                                              Icons.check_circle,
                                              color: Colors.white,
                                              size: 29,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container()
                              ],
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
