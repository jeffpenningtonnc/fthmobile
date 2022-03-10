import 'package:flutter/material.dart';
import 'package:fthmobile/Services/library_service.dart';
import 'package:fthmobile/Views/Library/library_subscribe_button.dart';
import '../../Services/account_service.dart';
import '../../Services/event_service.dart';
import '../Events/subscribe_icon.dart';

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
        title: const Text('Library Subscriptions'),
        backgroundColor: const Color.fromARGB(255, 142, 197, 95),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
                future: LibraryService.getSubscriptions(),
                builder: (context, response) {
                  if (response.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black)));
                  }

                  if (response.data == null || response.data.length == 0) {
                    return const Center(child: Text("No Results"));
                  }

                  return ListView.builder(
                    itemCount: response.data.length,
                    itemBuilder: (context, index) {
                      dynamic data = response.data[index];
                      String url = "https://admin.feedthehungerapp.com/api/uploads/" + data["ThumbFileName"] + "_256";

                      return Card(
                          child: ListTile(
                        leading: ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: 50,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Image.network(url, fit: BoxFit.cover),
                          ),
                        ),
                        title: Text(data["Title"]),
                        trailing: Padding(
                          padding: const EdgeInsets.fromLTRB(2, 10, 2, 10),
                          child: LibrarySubscribeButton(data: data),
                        ),
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
