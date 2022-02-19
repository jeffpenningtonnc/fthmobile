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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Follow Event'),
        backgroundColor: const Color.fromARGB(255, 142, 197, 95),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
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
                }
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Search",
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
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
          Expanded(
            child: FutureBuilder(
                future: EventService.findLiveEvents(_searchText, _nearMe, AccountService.userId),
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
                      return Card(
                          child: ListTile(
                        leading: ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 44,
                            minHeight: 44,
                            maxWidth: 64,
                            maxHeight: 64,
                          ),
                          child: Image.network(url, fit: BoxFit.cover),
                        ),
                        title: Text(data["Name"]),
                        subtitle: Text(data["City"] + ", " + data["State"]),
                        trailing: SubscribeIcon(
                            widget.key,
                            int.parse(data["OrganizationId"]),
                            data["Subscribed"] != null),
                      ));
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
