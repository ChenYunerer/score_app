import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PicturePage extends StatefulWidget{
  String pictureUrlStr;

  PicturePage(this.pictureUrlStr);

  @override
  State<StatefulWidget> createState() {
    return new PicturePageState();
  }

}

class PicturePageState extends State<PicturePage>{

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network(widget.pictureUrlStr),
    );
  }

}
