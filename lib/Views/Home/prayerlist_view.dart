import 'package:flutter/material.dart';
import 'package:fthmobile/Common/spinner.dart';
import 'package:fthmobile/Util/Globals.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrayerListView extends StatefulWidget {
  const PrayerListView({Key key}) : super(key: key);

  @override
  _PrayerListViewState createState() => _PrayerListViewState();
}

class _PrayerListViewState extends State<PrayerListView> {
  WebViewController _controller;
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Weekly Prayer List'),
            backgroundColor: Globals.getPrimaryColor(),
            centerTitle: true,
          ),
          body: Column(
            children: <Widget>[
              Visibility(
                visible: _loading,
                child: Container(
                  color: Colors.white,
                  child: const SizedBox(
                    height: 100,
                    child: Center(
                      child: Spinner(),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: _loading ? 0 : double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  padding: const EdgeInsets.all(0),
                  child: Center(
                    child: WebView(
                      initialUrl: 'https://admin.feedthehungerapp.com/api/mobile/WeeklyPrayerList.php',
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (WebViewController webViewController) {
                        _controller = webViewController;
                      },
                      onPageFinished: (finish) {
                        setState(() {
                          _loading = false;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}
