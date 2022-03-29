import 'package:flutter/material.dart';
import 'package:fthmobile/Services/library_service.dart';
import '../../Util/Globals.dart';

class DevotionalView extends StatefulWidget {
  const DevotionalView({Key key, this.data}) : super(key: key);

  final dynamic data;

  @override
  _DevotionalViewState createState() => _DevotionalViewState();
}

class _DevotionalViewState extends State<DevotionalView> {
  dynamic data;

  @override
  void initState() {
    data = widget.data;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devotional'),
        backgroundColor: Globals.getPrimaryColor(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network("https://admin.feedthehungerapp.com/api/devotionals/" + data["ResourceId"] + "/" + data["Day"] + ".jpg"),
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    child: Container(
                      width: 40,
                      height: 30,
                      color: const Color.fromARGB(150, 0, 0, 0),
                      child: const Icon(
                        Icons.arrow_back_ios_outlined,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () async {

                      int resourceId = int.parse(data["ResourceId"]);

                      int day = int.parse( data["Day"]);
                      day = day - 1;
                      if (day == 0) {
                        day = 1;
                      }

                      dynamic devo = await LibraryService.getDevotional(resourceId, day);

                      setState(() {
                        data = devo;
                      });

                    },
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    child: Container(
                      width: 40,
                      height: 30,
                      color: const Color.fromARGB(150, 0, 0, 0),
                      child: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () async {

                      int resourceId = int.parse(data["ResourceId"]);

                      int day = int.parse( data["Day"]);
                      day = day + 1;
                      if (day > 30) {
                        day = 30;
                      }

                      dynamic devo = await LibraryService.getDevotional(resourceId, day);

                      setState(() {
                        data = devo;
                      });

                    },
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(data["Title"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("by " + data["Author"],
                          style: const TextStyle(
                            fontSize: 14,
                          )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 18),
                      child: Text(data["Scripture"] + " - " + data["ScriptureRef"],
                          style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                    ),
                    Text(data["Content"],
                      style: const TextStyle(
                        fontSize: 16,
                      )
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
