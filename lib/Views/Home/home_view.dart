import 'package:flutter/material.dart';
import 'package:fthmobile/Common/title_bar.dart';
import 'package:video_player/video_player.dart';
import 'devotional_tile.dart';
import 'prayerlist_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key, this.setPage }) : super(key: key);

  final Function(int) setPage;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  VideoPlayerController controller;

  @override
  void initState() {
    loadVideoPlayer();
    super.initState();
  }

  void loadVideoPlayer() {
    controller = VideoPlayerController.asset('images/fth-drawing.mp4');
    controller.addListener(() {
      setState(() {});
    });
    controller.initialize().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: const Color.fromARGB(25, 100, 100, 100),
      child: Column(
        children: <Widget>[
          const TitleBar(title: "Welcome!"),
          Stack(
            children: [
              AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: Stack(
                  children: [
                    !controller.value.isPlaying
                        ? GestureDetector(
                            onTap: () {
                              controller.play();
                              setState(() {});
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "images/fth-drawing-thumb.png")),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              controller.pause();
                              controller.seekTo(Duration.zero);
                              setState(() {});
                            },
                            child: VideoPlayer(controller),
                          ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            color: Colors.black,
            height: 2,
          ),
          Expanded(
            child: ListView(
              children: [
                DevotionalTile(setPage: widget.setPage),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const PrayerListView()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              constraints: const BoxConstraints(
                                minWidth: 115,
                                minHeight: 115,
                                maxWidth: 115,
                                maxHeight: 115,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("images/prayerlist.png"),
                              ),
                            ),
                            Container(
                              child: Flexible(
                                child: Column(
                                  children: const [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
                                        child: Text("Weekly Prayer List",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                            )
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Prayer is the critical link between God and His people. Would you consider supporting us in prayer?",
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Prayer Needs >",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
