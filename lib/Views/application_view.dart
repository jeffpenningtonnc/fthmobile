import 'package:flutter/material.dart';
import '../Services/account_service.dart';
import 'donate_view.dart';
import 'library_view.dart';
import 'subscribed_view.dart';
import '../Widget/header.dart';
import 'home_view.dart';
import 'login_view.dart';
import 'news_view.dart';

class ApplicationView extends StatefulWidget {
  const ApplicationView({Key key}) : super(key: key);

  @override
  _ApplicationViewState createState() => _ApplicationViewState();
}

class _ApplicationViewState extends State<ApplicationView> {
  static int _currentIndex = 0;

  static final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  final List<Widget> _children = [
    HomeView(drawerKey: _drawerKey),
    NewsView(drawerKey: _drawerKey),
    SubscribedView(drawerKey: _drawerKey),
    LibraryView(drawerKey: _drawerKey),
    DonateView(drawerKey: _drawerKey),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 100),
        child: Header(widget.key, _drawerKey),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    child: Text(
                      AccountService.getInitials(),
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    radius: 40,
                    backgroundColor: const Color.fromARGB(255, 142, 197, 95),
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
        child: _children[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 142, 197, 95),
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
    );
  }
}
