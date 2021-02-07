import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photocontesthub/models/eventsModel.dart';
import 'package:photocontesthub/screens/home_page.dart';
import 'package:photocontesthub/services/firestore_services.dart';
import 'package:photocontesthub/utils/Constants.dart';
import 'package:photocontesthub/widgets/live_card.dart';
import 'package:photocontesthub/widgets/shimmer_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'LiveDetailsPage.dart';

class LivePage extends StatefulWidget {
  @override
  _LivePageState createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  FirestoreServices fireStoreServices = FirestoreServices();

  bool _loadingProducts = true;
  List<DocumentSnapshot> _listEvents = [];

  @override
  void initState() {
    getEvents();
    super.initState();
  }

  getEvents() {
    fireStoreServices.getEvents("Live").then((val) {
      _listEvents = val;
      setState(() {
        _loadingProducts = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white30,
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
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
                          Center(
                              child: Text(
                            "All the Results will be Declared on Time",
                            textAlign: TextAlign.center,
                          )),
                          Center(
                              child: Text(
                            "Winning Gifts or Prizes will be added to your wallet balance ",
                            textAlign: TextAlign.center,
                          )),
                          Center(
                              child: Text(
                            "Redeem your Wining Amount any time",
                            textAlign: TextAlign.center,
                          )),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      child: _loadingProducts == true
                          ? Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                child: Container(
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.black,
                                    highlightColor: Colors.white,
                                    enabled: true,
                                    child: ShimmerWidget(),
                                  ),
                                ),
                              ),
                            )
                          : _listEvents.length == 0
                              ? Center(
                                  child: Container(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Image.asset(
                                        "assets/images/app_logo.png",
                                        height: 100,
                                        width: 100,
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        "There are no any Live Contest",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      RaisedButton(
                                          color: Colors.indigo,
                                          child: Text(
                                            "Join Now",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return HomePage();
                                            }));
                                          })
                                    ],
                                  )),
                                )
                              : ListView.builder(
                                  itemCount: _listEvents.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    EventModels eventModels = EventModels(
                                      eventId:
                                          _listEvents[index].data["eventId"],
                                      resultDate:
                                          _listEvents[index].data["resultDate"],
                                      votingStartDate: _listEvents[index]
                                          .data["votingStartDate"],
                                      votingEndDate: _listEvents[index]
                                          .data["votingEndDate"],
                                      time: _listEvents[index].data["time"],
                                      title: _listEvents[index].data["title"],
                                      eventImage:
                                          _listEvents[index].data["eventImage"],
                                      status: _listEvents[index].data["status"],
                                      type: _listEvents[index].data["type"],
                                      entryFee:
                                          _listEvents[index].data["entryFee"],
                                      prize: _listEvents[index].data["prize"],
                                      prizeTwo:
                                          _listEvents[index].data["prizeTwo"],
                                      prizeThree:
                                          _listEvents[index].data["prizeThree"],
                                      prizeFour:
                                          _listEvents[index].data["prizeFour"],
                                      totalParticipated: _listEvents[index]
                                          .data["totalParticipated"],
                                      totalSlots:
                                          _listEvents[index].data["totalSlots"],
                                    );

                                    //

                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return LiveDetailsPage(
                                            eventsModel: eventModels,
                                          );
                                        }));
                                      },
                                      child: Card(
                                          elevation: 10,
                                          color: Colors.black12,
                                          child: LiveEventCards(
                                            eventModel: eventModels,
                                          )),
                                    );
                                  })),
                ],
              ),
            ],
          ),
        ));
  }
}
