import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../Widget/title_bar.dart';

class DonateView extends StatefulWidget {
  const DonateView({Key key, this.drawerKey}) : super(key: key);

  final GlobalKey<ScaffoldState> drawerKey;

  @override
  _DonateViewState createState() => _DonateViewState();
}

class _DonateViewState extends State<DonateView> {
  WebViewController _controller;
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: Column(
          children: <Widget>[
            TitleBar(title: "Donate"),
            Visibility(
              visible: _loading,
              child: Container(
                color: Colors.white,
                child: const SizedBox(
                  height: 100,
                    child: Center(
                        child: CircularProgressIndicator(),
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
                child: Center(
                  child: WebView(
                    initialUrl: 'https://www.feedthehungerapp.com/donate.html',
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


