import 'dart:io';
import 'package:fthmobile/Views/find_organization_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:fthmobile/Services/news_service.dart';

import '../Util/globals.dart';
import '../Widget/spinner.dart';

class AddNewsView extends StatefulWidget {
  const AddNewsView({
    Key key,
  }) : super(key: key);

  @override
  _AddNewsViewState createState() => _AddNewsViewState();
}

class _AddNewsViewState extends State<AddNewsView> {
  TextEditingController messageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File imageFile;
  bool uploading = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add News'),
          backgroundColor: Globals.getPrimaryColor(),
          centerTitle: true,
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundLocation),
              fit: BoxFit.cover,
            ),
          ),
          child: uploading
              ? Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                      ),
                      color: Colors.white,
                    ),
                    height: 100,
                    width: 300,
                    child: Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            "Uploading...",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Spinner(),
                      ],
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Colors.black26, width: 0.5),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title:
                                                  Text("Choose Organization"),
                                              content: Text("TEST"),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text("OK"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.location_on,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text("Katy, Texas"),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: RawMaterialButton(
                                    elevation: 0.0,
                                    child: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      final XFile photo =
                                          await _picker.pickImage(
                                              source: ImageSource.camera);
                                      imageFile = File(photo.path);

                                      setState(() {});
                                    },
                                    constraints: const BoxConstraints.tightFor(
                                      width: 40.0,
                                      height: 40.0,
                                    ),
                                    shape: const CircleBorder(),
                                    fillColor: Colors.black,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: RawMaterialButton(
                                    elevation: 0.0,
                                    child: const Icon(
                                      Icons.image,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      final XFile image =
                                          await _picker.pickImage(
                                              source: ImageSource.gallery);
                                      imageFile = File(image.path);

                                      setState(() {});
                                    },
                                    constraints: const BoxConstraints.tightFor(
                                      width: 40.0,
                                      height: 40.0,
                                    ),
                                    shape: const CircleBorder(),
                                    fillColor: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        imageFile == null
                            ? Container()
                            : Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.file(imageFile),
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                          child: TextField(
                            controller: messageController,
                            minLines: 3,
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: 'Message',
                              labelStyle: const TextStyle(
                                color: Colors.black,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.black26),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.black26),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(8.0),
                              color: Globals.getPrimaryColor(),
                              child: MaterialButton(
                                minWidth: 125,
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 10.0, 10.0, 10.0),
                                onPressed: () async {
                                  if (imageFile != null) {
                                    setState(() {
                                      uploading = true;
                                    });

                                    bool result = await NewsService.uploadFile(
                                        imageFile,
                                        17332225,
                                        messageController.text, (bool result) {
                                      setState(() {
                                        uploading = false;
                                      });

                                      Navigator.of(context).pop();
                                    });
                                  }
                                },
                                child: const Text(
                                  "Add",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ));
  }
}
