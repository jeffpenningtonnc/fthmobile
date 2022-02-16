import 'package:flutter/material.dart';
import '../Widget/title_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({Key key, this.drawerKey}) : super(key: key);

  final GlobalKey<ScaffoldState> drawerKey;

  @override
  _LibraryViewState createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  String dropdownValue = "All Items";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        TitleBar(widget.key, "Library"),
        DropdownButton(
          value: dropdownValue,
          hint: const Text('Filter'),
          icon: const Icon(Icons.arrow_drop_down),
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
            });
          },
          items: <String>['All Items', 'Subscribable', 'My Subscriptions']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        Expanded(
            child: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(0),
              crossAxisSpacing: 10,
              mainAxisSpacing: 20,
              crossAxisCount: 2,
              children: <Widget>[
                ListTile(
                  title: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(100, 100, 100, 100)),
                    child: Image.network(
                        "https://fth.jeffpenningtonnc.com/images/books/thumbs/AWordforAllOccasions_issuu-TH.png"),
                  ),
                  onTap: () async {
                    await launch(
                        "https://fth.jeffpenningtonnc.com/images/books/AWordforAllOccasions_issuu.pdf");
                  },
                ),
                ListTile(
                  title: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(100, 100, 100, 100)),
                    child: Image.network(
                        "https://fth.jeffpenningtonnc.com/images/books/thumbs/DiggingDeeper_book-TH.png"),
                  ),
                  onTap: () async {
                    await launch(
                        "https://fth.jeffpenningtonnc.com/images/books/DiggingDeeper_book.pdf");
                  },
                ),
                ListTile(
                  title: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(100, 100, 100, 100)),
                    child: Image.network(
                        "https://fth.jeffpenningtonnc.com/images/books/thumbs/Footprints_issuu-TH.png"),
                  ),
                  onTap: () async {
                    await launch(
                        "https://fth.jeffpenningtonnc.com/images/books/Footprints_issuu.pdf");
                  },
                ),
                ListTile(
                  title: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(100, 100, 100, 100)),
                    child: Image.network(
                        "https://fth.jeffpenningtonnc.com/images/books/thumbs/Terminus_book-TH.png"),
                  ),
                  onTap: () async {
                    await launch(
                        "https://fth.jeffpenningtonnc.com/images/books/Terminus_book.pdf");
                  },
                ),
                ListTile(
                  title: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(100, 100, 100, 100)),
                    child: Image.network(
                        "https://fth.jeffpenningtonnc.com/images/books/thumbs/TheBloodoftheSaints_book-TH.png"),
                  ),
                  onTap: () async {
                    await launch(
                        "https://fth.jeffpenningtonnc.com/images/books/TheBloodoftheSaints_book.pdf");
                  },
                ),
                ListTile(
                  title: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(100, 100, 100, 100)),
                    child: Image.network(
                        "https://fth.jeffpenningtonnc.com/images/books/thumbs/TheComingofChristos_book-TH.png"),
                  ),
                  onTap: () async {
                    await launch(
                        "https://fth.jeffpenningtonnc.com/images/books/TheComingofChristos_book.pdf");
                  },
                ),
                ListTile(
                  title: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(100, 100, 100, 100)),
                    child: Image.network(
                        "https://fth.jeffpenningtonnc.com/images/books/thumbs/TheJewishJesus_book_rev-TH.png"),
                  ),
                  onTap: () async {
                    await launch(
                        "https://fth.jeffpenningtonnc.com/images/books/TheJewishJesus_book_rev.pdf");
                  },
                ),
                ListTile(
                  title: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(100, 100, 100, 100)),
                    child: Image.network(
                        "https://fth.jeffpenningtonnc.com/images/books/thumbs/TheSearchforTruth_book-TH.png"),
                  ),
                  onTap: () async {
                    await launch(
                        "https://fth.jeffpenningtonnc.com/images/books/TheSearchforTruth_book.pdf");
                  },
                ),
              ],
            ),
          ),
        )),
      ],
    ));
  }
}
