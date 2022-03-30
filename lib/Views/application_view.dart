import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fthmobile/Common/header.dart';
import 'package:fthmobile/Common/spinner.dart';
import 'package:fthmobile/Services/account_service.dart';
import 'package:fthmobile/Services/event_service.dart';
import 'package:fthmobile/Util/Globals.dart';
import 'package:fthmobile/Views/Donate/donate_view.dart';
import 'package:fthmobile/Views/Events/subscribed_view.dart';
import 'package:fthmobile/Views/Home/home_view.dart';
import 'package:fthmobile/Views/Library/library_view.dart';
import 'package:fthmobile/Views/Login/login_view.dart';
import 'package:fthmobile/Views/News/news_view.dart';
import 'package:image_picker/image_picker.dart';

class ApplicationView extends StatefulWidget {
  const ApplicationView({Key key}) : super(key: key);

  @override
  _ApplicationViewState createState() => _ApplicationViewState();
}

class _ApplicationViewState extends State<ApplicationView> {
  static int _currentIndex = 0;
  String libraryInitialFilter = "All";

  final ImagePicker _picker = ImagePicker();
  File imageFile;
  NetworkImage _profileImage;

  @override
  void initState() {
    _profileImage = NetworkImage("https://admin.feedthehungerapp.com/api/profile/profile_" + AccountService.userId.toString() + ".png");
    super.initState();
  }

  void setPage(int index) {
    setState(() {
      libraryInitialFilter = "Devotionals";
      _currentIndex = index;
    });
  }

  Widget pageCaller(int index) {
    switch (index) {
      case 0:
        {
          return HomeView(setPage: setPage);
        }
      case 1:
        {
          return const NewsView();
        }
      case 2:
        {
          return const SubscribedView();
        }
      case 3:
        {
          Widget w = LibraryView(initialFilter: libraryInitialFilter);
          libraryInitialFilter = "All";
          return w;
        }
      case 4:
        {
          return const DonateView();
        }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        key: GlobalKey(),
        appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 100),
          child: Header(),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        final XFile image = await _picker.pickImage(source: ImageSource.gallery);
                        imageFile = File(image.path);

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => AlertDialog(
                            title: const Text("Uploading Profile Image"),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Spinner(),
                              ],
                            ),
                          ),
                        );

                        bool result = await AccountService.uploadProfileImage(imageFile, (bool result) {
                          setState(() {});

                          Navigator.of(context).pop();
                          //Navigator.pop(context);
                        });
                      },
                      child: CircleAvatar(
                        child: ClipOval(
                          child: Container(
                            width: 50,
                            height: 50,
                            child: Image.network(
                              "https://admin.feedthehungerapp.com/api/profile/profile_" + AccountService.userId.toString() + ".png",
                              errorBuilder: (context, error, stackTrace) => CircleAvatar(
                                child: Text(
                                  AccountService.getInitials(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                radius: 24,
                                backgroundColor: Globals.getPrimaryColor(),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        backgroundColor: Colors.transparent,
                        radius: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      AccountService.getFullName(),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      AccountService.userEmail,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
              ),
              // ListTile(
              //   title: Row(
              //     children: const <Widget>[Icon(Icons.person), Text("Profile")],
              //   ),
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => const LoginView()),
              //     );
              //   },
              // ),
              // ListTile(
              //   title: Row(
              //     children: const <Widget>[Icon(Icons.lock), Text("Change Password")],
              //   ),
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => const LoginView()),
              //     );
              //   },
              // ),
              ListTile(
                title: Row(
                  children: const <Widget>[Icon(Icons.exit_to_app), Text("Logout")],
                ),
                onTap: () {
                  AccountService.logOut();

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginView()),
                  );
                },
              ),
            ],
          ),
        ),
        body: Container(
          child: pageCaller(_currentIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Globals.getPrimaryColor(),
          backgroundColor: Colors.white38,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          currentIndex: _currentIndex,
          // this will be set when a new tab is tapped
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.comment),
              label: "News",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event),
              label: "Events",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: "Library",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: "Donate",
            ),
          ],
        ),
      ),
    );
  }
}
