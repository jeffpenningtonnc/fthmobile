import 'package:flutter/material.dart';
import '../Services/account_service.dart';
import '../Services/event_service.dart';
import '../Widget/subscribe_icon.dart';

class SubscribeView extends StatefulWidget {
  const SubscribeView({Key key}) : super(key: key);

  @override
  _SubscribeViewState createState() => _SubscribeViewState();
}

class _SubscribeViewState extends State<SubscribeView> {
  TextEditingController searchController = TextEditingController();
  String _searchText = "";
  bool _nearMe = true;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Follow Event'),
          backgroundColor: const Color.fromARGB(255, 142, 197, 95),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Search",
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white38, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white38, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (text) {
                  setState(() {
                    _searchText = searchController.text;
                  });
                },
              ),
            ),
            Row(
              children: <Widget>[
                const SizedBox(
                  width: 12,
                ),
                const Text(
                  "Events Near Me:",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Checkbox(
                    value: _nearMe,
                    checkColor: Colors.white,
                    activeColor: Colors.black,
                    onChanged: (bool value) {
                      setState(() {
                        _nearMe = value;
                      });
                    }),
              ],
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                color: const Color.fromARGB(255, 230, 230, 230),
                child: FutureBuilder(
                    future: EventService.findLiveEvents(
                        _searchText, _nearMe, AccountService.userId),
                    builder: (context, response) {
                      if (response.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.black)));
                      }

                      if (response.data == null || response.data.length == 0) {
                        return const Center(child: Text("No Results"));
                      }

                      return ListView.builder(
                        itemCount: response.data.length,
                        itemBuilder: (context, index) {
                          dynamic data = response.data[index];
                          String url =
                              "https://admin.feedthehungerapp.com/api/uploads/" +
                                  data["FileName"] +
                                  "_256";
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                            child: Card(
                                child: ListTile(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              leading: Container(
                                constraints: const BoxConstraints(
                                  minWidth: 85,
                                  minHeight: 70,
                                  maxWidth: 85,
                                  maxHeight: 70,
                                ),
                                padding: const EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
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
                              subtitle: Text(data["City"] + ", " + data["State"]),
                              trailing: SubscribeIcon(
                                  widget.key,
                                  int.parse(data["OrganizationId"]),
                                  data["Subscribed"] != null),
                            )),
                          );
                        },
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
