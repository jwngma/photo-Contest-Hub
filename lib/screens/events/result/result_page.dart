//import 'package:carousel_pro/carousel_pro.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
//import 'package:photocontesthub/models/eventsModel.dart';
//import 'package:photocontesthub/screens/events/events_page.dart';
//import 'package:photocontesthub/services/firestore_services.dart';
//import 'package:photocontesthub/utils/Constants.dart';
//import 'package:photocontesthub/widgets/ended_card.dart';
//import 'package:photocontesthub/widgets/shimmer_widget.dart';
//import 'package:shimmer/shimmer.dart';
//
//import 'ResultDetailsPage.dart';
//
//class ResultPage extends StatefulWidget {
//  @override
//  _ResultPageState createState() => _ResultPageState();
//}
//
//class _ResultPageState extends State<ResultPage> {
//  FirestoreServices fireStoreServices = FirestoreServices();
//  bool _loadingProducts = true;
//  List<DocumentSnapshot> _listEvents = [];
//
//  @override
//  void initState() {
//    getEvents();
//    super.initState();
//  }
//
//  getEvents() {
//    fireStoreServices.getEventsA("Ended", PhotoContestHub.Events).then((val) {
//      _listEvents = val;
//      setState(() {
//        _loadingProducts = false;
//      });
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        backgroundColor: Colors.white,
//        body: SingleChildScrollView(
//          child: Stack(
//            children: <Widget>[
//              Column(
//                children: <Widget>[
//                  Padding(
//                    padding:
//                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//                    child: Container(
//                      width: MediaQuery.of(context).size.width,
//                      height: MediaQuery.of(context).size.height * 0.1,
//                      decoration: BoxDecoration(
//                          color: Colors.green,
//                          borderRadius: BorderRadius.all(Radius.circular(5))),
//                      child: Carousel(
//                        boxFit: BoxFit.cover,
//                        autoplay: true,
//                        animationCurve: Curves.fastOutSlowIn,
//                        animationDuration: Duration(milliseconds: 1000),
//                        dotSize: 6.0,
//                        dotIncreasedColor: Color(0xFFFF335C),
//                        dotBgColor: Colors.transparent,
//                        dotPosition: DotPosition.bottomCenter,
//                        dotVerticalPadding: 10.0,
//                        showIndicator: true,
//                        indicatorBgPadding: 7.0,
//                        images: [
//                          Center(
//                              child: Text(
//                            "All the Results will be Declared on Time",
//                            textAlign: TextAlign.center,
//                          )),
//                          Center(
//                              child: Text(
//                            "Winning Gifts or Prizes will be added to your wallet balance ",
//                            textAlign: TextAlign.center,
//                          )),
//                          Center(
//                              child: Text(
//                            "Redeem your Wining Amount any time",
//                            textAlign: TextAlign.center,
//                          )),
//                        ],
//                      ),
//                    ),
//                  ),
//
//                  /////////////////////////////////
//                  ///
//
//                  Container(
//                      child: _loadingProducts == true
//                          ? Padding(
//                              padding: const EdgeInsets.all(20.0),
//                              child: Container(
//                                child: Container(
//                                  child: Shimmer.fromColors(
//                                    baseColor: Colors.black,
//                                    highlightColor: Colors.white,
//                                    enabled: true,
//                                    child: ShimmerWidget(),
//                                  ),
//                                ),
//                              ),
//                            )
//                          : _listEvents.length == 0
//                              ? Center(
//                                  child: Container(
//                                      child: Column(
//                                    mainAxisAlignment: MainAxisAlignment.center,
//                                    children: <Widget>[
//                                      SizedBox(
//                                        height: 10,
//                                      ),
//                                      Image.asset(
//                                        "assets/images/app_logo.png",
//                                        height: 100,
//                                        width: 100,
//                                      ),
//                                      SizedBox(
//                                        height: 30,
//                                      ),
//                                      Text(
//                                        "There are no any Completed Contest Yet",
//                                        textAlign: TextAlign.center,
//                                        style: TextStyle(color: Colors.green),
//                                      ),
//                                    ],
//                                  )),
//                                )
//                              : ListView.builder(
//                                  itemCount: _listEvents.length,
//                                  physics: NeverScrollableScrollPhysics(),
//                                  shrinkWrap: true,
//                                  itemBuilder: (context, index) {
//                                    EventModels eventModels = EventModels(
//                                      eventId:
//                                          _listEvents[index].data["eventId"],
//                                      resultDate:
//                                          _listEvents[index].data["resultDate"],
//                                      votingStartDate: _listEvents[index]
//                                          .data["votingStartDate"],
//                                      votingEndDate: _listEvents[index]
//                                          .data["votingEndDate"],
//                                      time: _listEvents[index].data["time"],
//                                      title: _listEvents[index].data["title"],
//                                      eventImage:
//                                          _listEvents[index].data["eventImage"],
//                                      status: _listEvents[index].data["status"],
//                                      type: _listEvents[index].data["type"],
//                                      entryFee:
//                                          _listEvents[index].data["entryFee"],
//                                      prize: _listEvents[index].data["prize"],
//                                      prizeTwo:
//                                          _listEvents[index].data["prizeTwo"],
//                                      prizeThree:
//                                          _listEvents[index].data["prizeThree"],
//                                      totalParticipated: _listEvents[index]
//                                          .data["totalParticipated"],
//                                      totalSlots:
//                                          _listEvents[index].data["totalSlots"],
//                                    );
//
//                                    //
//
//                                    return GestureDetector(
//                                      onTap: () {
//                                        Navigator.push(context,
//                                            MaterialPageRoute(
//                                                builder: (context) {
//                                          return ResultDetailsPage(
//                                            eventsModel: eventModels,
//                                          );
//                                        }));
//                                      },
//                                      child: Card(
//                                          elevation: 10,
//                                          color: Colors.black12,
//                                          child: EndedEventCards(
//                                            eventModel: eventModels,
//                                          )),
//                                    );
//                                  })),
//
//                  /////////////////////////////////////
//                  // StreamBuilder(
//                  //     stream: stream,
//                  //     builder: (context, snapshots) {
//                  //       switch (snapshots.connectionState) {
//                  //         case ConnectionState.waiting:
//                  //           print("waiting");
//                  //           return Center(child: CircularProgressIndicator());
//                  //           break;
//                  //         case ConnectionState.active:
//                  //           print("active");
//
//                  //           if (!snapshots.hasData) {
//                  //             return Text(
//                  //               "Empty",
//                  //               style: TextStyle(color: Colors.red),
//                  //             );
//                  //           } else {
//                  //             return ListView.builder(
//                  //                 shrinkWrap: true,
//                  //                 physics: NeverScrollableScrollPhysics(),
//                  //                 itemCount: snapshots.data.documents.length,
//                  //                 itemBuilder: (context, index) {
//                  //                   EventModels eventModels = EventModels(
//                  //                     eventId: snapshots.data.documents[index]
//                  //                         .data["eventId"],
//                  //                     resultDate: snapshots.data
//                  //                         .documents[index].data["resultDate"],
//                  //                     votingStartDate: snapshots
//                  //                         .data
//                  //                         .documents[index]
//                  //                         .data["votingStartDate"],
//                  //                     votingEndDate: snapshots
//                  //                         .data
//                  //                         .documents[index]
//                  //                         .data["votingEndDate"],
//                  //                     time: snapshots
//                  //                         .data.documents[index].data["time"],
//                  //                     title: snapshots
//                  //                         .data.documents[index].data["title"],
//                  //                     eventImage: snapshots.data
//                  //                         .documents[index].data["eventImage"],
//                  //                     status: snapshots
//                  //                         .data.documents[index].data["status"],
//                  //                     type: snapshots
//                  //                         .data.documents[index].data["type"],
//                  //                     entryFee: snapshots.data.documents[index]
//                  //                         .data["entryFee"],
//                  //                     prize: snapshots
//                  //                         .data.documents[index].data["prize"],
//                  //                     prizeTwo: snapshots.data.documents[index]
//                  //                         .data["prizeTwo"],
//                  //                     prizeThree: snapshots.data
//                  //                         .documents[index].data["prizeThree"],
//                  //                     prizeFour: snapshots.data.documents[index]
//                  //                         .data["prizeFour"],
//                  //                     totalParticipated: snapshots
//                  //                         .data
//                  //                         .documents[index]
//                  //                         .data["totalParticipated"],
//                  //                     totalSlots: snapshots.data
//                  //                         .documents[index].data["totalSlots"],
//                  //                   );
//                  //                   return GestureDetector(
//                  //                     onTap: () {
//                  //                       Navigator.push(context,
//                  //                           MaterialPageRoute(
//                  //                               builder: (context) {
//                  //                         return ResultDetailsPage(
//                  //                           eventsModel: eventModels,
//                  //                         );
//                  //                       }));
//                  //                     },
//                  //                     child: Card(
//                  //                         elevation: 10,
//                  //                         color: Colors.green,
//                  //                         child: EndedEventCards(
//                  //                           eventModel: eventModels,
//                  //                         )),
//                  //                   );
//                  //                 });
//                  //           }
//
//                  //           break;
//                  //         case ConnectionState.none:
//                  //           print("none");
//                  //           return Center(
//                  //               child: Text(
//                  //             "No Events",
//                  //             style: TextStyle(color: Colors.black),
//                  //           ));
//                  //           break;
//                  //         default:
//                  //           if (snapshots.hasError) {
//                  //             return Text('Error: ${snapshots.error}');
//                  //           } else {
//                  //             return Text(
//                  //               'Button tapped ${snapshots.data} time${snapshots.data == 1 ? '' : 's'}.\n\n'
//                  //               'This should persist across restarts.',
//                  //             );
//                  //           }
//                  //       }
//                  //     }),
//                ],
//              ),
//            ],
//          ),
//        ));
//  }
//}
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photocontesthub/models/eventsModel.dart';
import 'file:///D:/flutter_projects/final_project/photo_contest_hub/photo_contest_hub/lib/screens/events/upcoming/events_page.dart';
import 'package:photocontesthub/services/firestore_services.dart';
import 'package:photocontesthub/utils/Constants.dart';
import 'package:photocontesthub/widgets/ended_card.dart';
import 'package:photocontesthub/widgets/shimmer_widget.dart';
import 'package:shimmer/shimmer.dart';

import 'ResultDetailsPage.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  FirestoreServices fireStoreServices = FirestoreServices();
  bool _loadingProducts = true;
  List<DocumentSnapshot> _listEvents = [];

  @override
  void initState() {
    getEvents();
    super.initState();
  }

  getEvents() {
    fireStoreServices.getEvents("Ended").then((val) {
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

                  /////////////////////////////////
                  ///

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
                                  "There are no any Completed Contest Yet",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.green),
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
                                          return ResultDetailsPage(
                                            eventsModel: eventModels,
                                          );
                                        }));
                              },
                              child: Card(
                                  elevation: 10,
                                  color: Colors.black12,
                                  child: EndedEventCards(
                                    eventModel: eventModels,
                                  )),
                            );
                          })),

                  /////////////////////////////////////
                  // StreamBuilder(
                  //     stream: stream,
                  //     builder: (context, snapshots) {
                  //       switch (snapshots.connectionState) {
                  //         case ConnectionState.waiting:
                  //           print("waiting");
                  //           return Center(child: CircularProgressIndicator());
                  //           break;
                  //         case ConnectionState.active:
                  //           print("active");

                  //           if (!snapshots.hasData) {
                  //             return Text(
                  //               "Empty",
                  //               style: TextStyle(color: Colors.red),
                  //             );
                  //           } else {
                  //             return ListView.builder(
                  //                 shrinkWrap: true,
                  //                 physics: NeverScrollableScrollPhysics(),
                  //                 itemCount: snapshots.data.documents.length,
                  //                 itemBuilder: (context, index) {
                  //                   EventModels eventModels = EventModels(
                  //                     eventId: snapshots.data.documents[index]
                  //                         .data["eventId"],
                  //                     resultDate: snapshots.data
                  //                         .documents[index].data["resultDate"],
                  //                     votingStartDate: snapshots
                  //                         .data
                  //                         .documents[index]
                  //                         .data["votingStartDate"],
                  //                     votingEndDate: snapshots
                  //                         .data
                  //                         .documents[index]
                  //                         .data["votingEndDate"],
                  //                     time: snapshots
                  //                         .data.documents[index].data["time"],
                  //                     title: snapshots
                  //                         .data.documents[index].data["title"],
                  //                     eventImage: snapshots.data
                  //                         .documents[index].data["eventImage"],
                  //                     status: snapshots
                  //                         .data.documents[index].data["status"],
                  //                     type: snapshots
                  //                         .data.documents[index].data["type"],
                  //                     entryFee: snapshots.data.documents[index]
                  //                         .data["entryFee"],
                  //                     prize: snapshots
                  //                         .data.documents[index].data["prize"],
                  //                     prizeTwo: snapshots.data.documents[index]
                  //                         .data["prizeTwo"],
                  //                     prizeThree: snapshots.data
                  //                         .documents[index].data["prizeThree"],
                  //                     prizeFour: snapshots.data.documents[index]
                  //                         .data["prizeFour"],
                  //                     totalParticipated: snapshots
                  //                         .data
                  //                         .documents[index]
                  //                         .data["totalParticipated"],
                  //                     totalSlots: snapshots.data
                  //                         .documents[index].data["totalSlots"],
                  //                   );
                  //                   return GestureDetector(
                  //                     onTap: () {
                  //                       Navigator.push(context,
                  //                           MaterialPageRoute(
                  //                               builder: (context) {
                  //                         return ResultDetailsPage(
                  //                           eventsModel: eventModels,
                  //                         );
                  //                       }));
                  //                     },
                  //                     child: Card(
                  //                         elevation: 10,
                  //                         color: Colors.green,
                  //                         child: EndedEventCards(
                  //                           eventModel: eventModels,
                  //                         )),
                  //                   );
                  //                 });
                  //           }

                  //           break;
                  //         case ConnectionState.none:
                  //           print("none");
                  //           return Center(
                  //               child: Text(
                  //             "No Events",
                  //             style: TextStyle(color: Colors.black),
                  //           ));
                  //           break;
                  //         default:
                  //           if (snapshots.hasError) {
                  //             return Text('Error: ${snapshots.error}');
                  //           } else {
                  //             return Text(
                  //               'Button tapped ${snapshots.data} time${snapshots.data == 1 ? '' : 's'}.\n\n'
                  //               'This should persist across restarts.',
                  //             );
                  //           }
                  //       }
                  //     }),
                ],
              ),
            ],
          ),
        ));
  }
}
