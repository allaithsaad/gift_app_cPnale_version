import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class LikeBotton extends StatelessWidget {
  final bool likeValue;
  LikeBotton(this.likeValue);
  @override
  Widget build(BuildContext context) {
    return LikeButton(
      isLiked: likeValue,
      onTap: (isLiked) => onLikeButtonTapped(likeValue),
      size: 30,
      circleColor:
          CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
      bubblesColor: BubblesColor(
        dotPrimaryColor: Color(0xff33b5e5),
        dotSecondaryColor: Color(0xff0099cc),
      ),
      likeBuilder: (isLiked) {
        return Icon(
          Icons.shop_2,
          color: isLiked ? Colors.redAccent : Colors.white,
          size: 25,
        );
      },
//      likeCount: 665,
//      countBuilder: (int count, bool isLiked, String text) {
//        var color = isLiked ? Colors.red : Colors.white;
//        Widget result;
//        if (count == 0) {
//          result = Text(
//            "love",
//            style: TextStyle(color: color,fontSize: 10),
//          );
//        } else
//          result = Text(
//            text,
//            style: TextStyle(color: color,fontSize: 10),
//          );
//        return result;
//      },
    );
  }

  Future<bool> onLikeButtonTapped(isLiked) async {
    return !isLiked;
  }
}
