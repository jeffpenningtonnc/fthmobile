import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../Widget/title_bar.dart';
import 'package:image_slider/image_slider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key, this.drawerKey}) : super(key: key);

  final GlobalKey<ScaffoldState> drawerKey;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  TabController tabController;
  WebViewController _controller;
  bool _loading = true;

  // static List<String> links = [
  //   "https://admin.feedthehungerapp.com/images/slider/slider1.png",
  //   "https://admin.feedthehungerapp.com/images/slider/slider2.png",
  //   "https://admin.feedthehungerapp.com/images/slider/slider3.png",
  //   "https://admin.feedthehungerapp.com/images/slider/slider4.png"
  // ];

  static List<String> links = [
    "images/slider/slider1.png",
    "images/slider/slider2.png",
    "images/slider/slider3.png",
    "images/slider/slider4.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            TitleBar(widget.key, "Welcome!"),
            Container(
              color: Colors.black,
              child: ImageSlider(
                showTabIndicator: false,

                /// Customize tab's colors
                tabIndicatorColor: Colors.white70,

                /// Customize selected tab's colors
                tabIndicatorSelectedColor: Colors.yellow,

                /// Height of the indicators from the bottom
                tabIndicatorHeight: 16,

                /// Size of the tab indicator circles
                tabIndicatorSize: 16,

                /// tabController for walkthrough or other implementations
                tabController: tabController,

                /// Animation curves of sliding
                curve: Curves.easeIn,

                /// Width of the slider
                width: MediaQuery.of(context).size.width,

                /// Height of the slider
                height: 220,

                /// If automatic sliding is required
                autoSlide: true,

                /// Time for automatic sliding
                duration: const Duration(seconds: 6),

                /// If manual sliding is required
                allowManualSlide: true,
                children: links.map((String link) {
                  return Image.asset(
                    link,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: WebView(
                initialUrl: 'https://mailchi.mp/feedthehunger/prayer-2-20-22',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller = webViewController;
                },
                onPageFinished: (finish) {

                  _controller.evaluateJavascript("document.getElementById('templatePreheader').remove(); ");

                  setState(() {
                    _loading = false;
                  });
                },
              ),
            ),
          ],
        ));
  }
}
