import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:fthmobile/Services/news_service.dart';

import '../Util/globals.dart';

class AddNewsView extends StatefulWidget {
  const AddNewsView({
    Key key,
  }) : super(key: key);

  @override
  _AddNewsViewState createState() => _AddNewsViewState();
}

class _AddNewsViewState extends State<AddNewsView> {
  final ImagePicker _picker = ImagePicker();
  File imageFile;

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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            onPressed: () async {
                              final XFile photo = await _picker.pickImage(
                                  source: ImageSource.camera);
                              imageFile = File(photo.path);

                              setState(() {

                              });
                            },
                            icon: const Icon(Icons.camera_alt,
                              size: 32,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              final XFile image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              imageFile = File(image.path);

                              setState(() {

                              });
                            },
                            icon: const Icon(Icons.image,
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  imageFile == null
                      ? Container()
                      : ListTile(
                          contentPadding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                          title: Image.file(imageFile),
                        ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                    child: TextField(
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
                          borderSide:
                              const BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(8.0),
                      color: Globals.getPrimaryColor(),
                      child: MaterialButton(
                        minWidth: 125,
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        onPressed: () async {},
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
                ],
              ),
            ),
          ),
        ));
  }
}
