import 'package:flutter/material.dart';
import '../Services/account_service.dart';
import '../Services/event_service.dart';
import '../Widget/subscribe_icon.dart';

class LibraryManageView extends StatefulWidget {
  const LibraryManageView({Key key}) : super(key: key);

  @override
  _LibraryManageViewState createState() => _LibraryManageViewState();
}

class _LibraryManageViewState extends State<LibraryManageView> {

  TextEditingController searchController = TextEditingController();
  String _searchText = "";
  bool _nearMe = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Subscriptions'),
        backgroundColor: const Color.fromARGB(255, 142, 197, 95),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
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
