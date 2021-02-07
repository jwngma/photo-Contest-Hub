import 'package:flutter/material.dart';

class BookPhotoGrapher extends StatefulWidget {
  @override
  _BookPhotoGrapherState createState() => _BookPhotoGrapherState();
}

class _BookPhotoGrapherState extends State<BookPhotoGrapher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white30,
      body: Center(
        child: Text(
          "Booking Photographer for special Events are comming up soon here",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
