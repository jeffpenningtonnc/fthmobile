import 'package:flutter/material.dart';

import '../../Services/news_service.dart';

class LikeNews extends StatefulWidget {
  const LikeNews({Key key, this.data}) : super(key: key);

  final dynamic data;

  @override
  _LikeNewsState createState() => _LikeNewsState();
}

class _LikeNewsState extends State<LikeNews> {

  bool isLiked = false;
  int likes = 0;

  @override
  void initState() {
    isLiked = widget.data["liked"] != null && widget.data["liked"] == "1";
    likes = int.parse(widget.data["likes"]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Row(
          children: [
            isLiked ? const Icon(Icons.thumb_up, color: Colors.blueAccent) : const Icon(Icons.thumb_up_alt_outlined, color: Colors.grey),
            const Padding(
              padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
              child: Text("Like",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
              child: likes > 0 ? Text("(" + likes.toString() + ")") : const Text(""),
            ),
          ],
        ),
        onTap: () {
          NewsService.likeItem(widget.data["EventResourceId"], !isLiked);

          setState(() {
            isLiked = !isLiked;
          });
        }
    );
  }
}
