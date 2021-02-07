import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photocontesthub/models/eventsModel.dart';
import 'package:photocontesthub/services/firestore_services.dart';
import 'package:photocontesthub/utils/Constants.dart';
import 'package:photocontesthub/widgets/carousel_widget.dart';
import 'package:photocontesthub/widgets/events_card.dart';
import 'package:photocontesthub/widgets/shimmer_widget.dart';
import 'package:shimmer/shimmer.dart';

import 'event_details_page.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  FirestoreServices fireStoreServices = FirestoreServices();

  bool _loadingProducts = true;
  List<DocumentSnapshot> _listEvents = [];

  @override
  void initState() {
    getEvents();
    super.initState();
  }

  getEvents() {
    fireStoreServices
        .getEvents("Upcoming")
        .then((val) {
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
                  SizedBox(height: 10,),
                  SizedBox(
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
                  SizedBox(height: 10,),
                  Text(
                    "Photo Contest Hub",
                    style: GoogleFonts.oranienbaum(color: Colors.green,
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Share your image and Earn from it",
                    style: TextStyle(fontSize: 8, color: Colors.white),
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
                                        "There are no any OnGoing Contest",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
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
                                      time: _listEvents[index].data["time"],
                                      eventImage:
                                          _listEvents[index].data["eventImage"],
                                      status: _listEvents[index].data["status"],
                                      title: _listEvents[index].data["title"],
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
                                      votingEndDate: _listEvents[index]
                                          .data["votingEndDate"],
                                      votingStartDate: _listEvents[index]
                                          .data["votingStartDate"],
                                    );

                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return EventDetailsPage(
                                            eventsModel: eventModels,
                                          );
                                        }));
                                      },
                                      child: Card(
                                          elevation: 10,
                                          color: Colors.green,
                                          child: EventCards(
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
