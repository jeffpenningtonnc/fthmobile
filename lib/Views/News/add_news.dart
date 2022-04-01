import 'dart:io';
import 'package:fthmobile/Common/spinner.dart';
import 'package:fthmobile/Services/event_service.dart';
import 'package:fthmobile/Util/Globals.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:fthmobile/Services/news_service.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';

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
  int _selectedEvent = 0;

  @override
  void initState() {
    _selectedEvent = EventService.selectedNewsEvent;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
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
                              "Saving...",
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
                                    side: const BorderSide(color: Colors.black26, width: 0.5),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.location_on,
                                          color: Colors.black,
                                        ),
                                      ),
                                      FutureBuilder(
                                        future: EventService.getNewsEventsList(),
                                        builder: (evtContext, response) {
                                          List<Organization> organizations = [];

                                          if (response.data == null) {
                                            return const Text("No Subscribed Events");
                                          }

                                          for (var org in response.data) {
                                            organizations.add(Organization(int.parse(org["EventId"]), org["EventName"]));
                                          }

                                          return Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                              child: DropdownButton(
                                                elevation: 0,
                                                isExpanded: true,
                                                hint: const Text("Location"),
                                                value: _selectedEvent == 0 ? null : _selectedEvent,
                                                items: organizations.map((Organization item) {
                                                  return DropdownMenuItem(
                                                    value: item.id,
                                                    child: Text(
                                                      item.name,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 14
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (int value) {
                                                  setState(() {
                                                    _selectedEvent = value;
                                                    EventService.selectedNewsEvent = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      ),
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
                                        final XFile photo = await _picker.pickImage(source: ImageSource.camera);
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
                                        final XFile image = await _picker.pickImage(source: ImageSource.gallery);
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
                                  borderSide: const BorderSide(width: 1, color: Colors.black26),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 1, color: Colors.black26),
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
                                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                  onPressed: () async {

                                    if (_selectedEvent == 0) {

                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (alertCtx) => AlertDialog(
                                          title: const Text("Missing Location"),
                                          content: const Text("Please select the location."),
                                          actions: <Widget>[
                                            MaterialButton(
                                              onPressed: () {
                                                Navigator.of(alertCtx).pop();
                                              },
                                              child: const Text("Close"),
                                            ),
                                          ],
                                        ),
                                      );

                                      return;
                                    }

                                    // Add Post with image
                                    if (imageFile != null) {
                                      setState(() {
                                        uploading = true;
                                      });

                                      File rotatedImage = await FlutterExifRotation.rotateAndSaveImage(path: imageFile.path);

                                      bool result = await NewsService.uploadFile(rotatedImage, _selectedEvent, messageController.text, (bool result) {
                                        setState(() {
                                          uploading = false;
                                        });

                                        Navigator.of(context).pop();
                                      });
                                    }

                                    // Add post without image
                                    else {

                                      setState(() {
                                        uploading = true;
                                      });

                                      try {
                                        if (messageController.text.isNotEmpty) {
                                          await NewsService.addMessage(_selectedEvent, messageController.text);
                                        }
                                      }
                                      finally {
                                        setState(() {
                                          uploading = false;
                                        });
                                        Navigator.of(context).pop();
                                      }
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
          )),
    );
  }
}

class Organization {
  final int id;
  final String name;

  Organization(this.id, this.name);
}
