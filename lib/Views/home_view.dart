import 'package:flutter/material.dart';
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

  static List<String> links = [
    "https://admin.feedthehungerapp.com/images/slider/slider1.png",
    "https://admin.feedthehungerapp.com/images/slider/slider2.png",
    "https://admin.feedthehungerapp.com/images/slider/slider3.png",
    "https://admin.feedthehungerapp.com/images/slider/slider4.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          TitleBar(widget.key, "Welcome!"),
          Container(
            color: Colors.black,
            child: ImageSlider(
              showTabIndicator: true,

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
                return Image.network(
                  link,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                );
              }).toList(),
            ),
          ),
          Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black
                  ),
                ),
              ),
              SizedBox(
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.network(
                        "https://admin.feedthehungerapp.com/images/slider/home-bottom.png",
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
