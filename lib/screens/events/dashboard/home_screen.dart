import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photocontesthub/models/FeedModel.dart';
import 'package:photocontesthub/services/facebook_services.dart';
import 'package:photocontesthub/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:photocontesthub/utils/Constants.dart';
import 'package:photocontesthub/wallet/feed_cards.dart';
import 'package:photocontesthub/widgets/carousel_widget.dart';
import 'package:photocontesthub/widgets/shimmer_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showLoading = true;
  FirestoreServices fireStoreServices = FirestoreServices();

  List<DocumentSnapshot> _listEvents = [];
  FacebookServices facebookServices = FacebookServices();
  List<Data> feedList = List();

  @override
  void initState() {
    super.initState();
  }

  getFeeds() async {
    await facebookServices.getFeed().then((val) async {
      setState(() {
        feedList = val;
      });
    });
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    final facebookProvider =
    Provider.of<FacebookServices>(context, listen: false);
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Center(
              child: SizedBox(
                height: 150.0,
                width: 300.0,
                child: Carousel(
                  boxFit: BoxFit.cover,
                  autoplay: true,
                  animationCurve: Curves.fastOutSlowIn,
                  animationDuration: Duration(milliseconds: 1000),
                  dotSize: 6.0,
                  dotIncreasedColor: Color(0xFFFF335C),
                  dotBgColor: Colors.transparent,
                  dotPosition: DotPosition.bottomCenter,
                  dotVerticalPadding: 10.0,
                  showIndicator: true,
                  indicatorBgPadding: 7.0,
                  images: [
                    corouselCard(
                        "https://images.unsplash.com/photo-1590320779846-49d127b212c3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=387&q=80"),
                    corouselCard(
                        "https://images.unsplash.com/photo-1587613754067-13e9a170b42f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"),
                    corouselCard(
                        "https://images.unsplash.com/photo-1590311825124-73ec5233cb0a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"),
                    corouselCard(
                        "https://images.unsplash.com/photo-1589566856613-dd9869b55ed1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"),
                    corouselCard(
                        "https://images.unsplash.com/photo-1590308271679-377022ab7047?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Photo Contest Hub",
              style: GoogleFonts.oranienbaum(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              "Share your image and Earn from it",
              style: TextStyle(fontSize: 8),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("This is Home Screen"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                  future: facebookProvider.getFeed(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var myData = snapshot.data;
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: myData.length,
                          itemBuilder: (context, index) {
                            List<Data> list_feedmodel = myData;
                            return Card(
                                color: Colors.white,
                                child: HomeFeedCards(list_feedmodel[index]));
                          });
                    } else {
                      return Center(
                        child: new CircularProgressIndicator(
                          backgroundColor: Colors.green,
                          strokeWidth: 4,
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    ));
  }
}
