import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PicturePage extends StatefulWidget{
  String pictureUrlStr;

  PicturePage(this.pictureUrlStr);

  @override
  State<StatefulWidget> createState() {
    return new PicturePageState(pictureUrlStr);
  }

}

class PicturePageState extends State<PicturePage>{
  String pictureUrlStr;


  PicturePageState(this.pictureUrlStr);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: pictureUrlStr == null ? CircularProgressIndicator() : Image
          .network(pictureUrlStr),
    );
  }

}
