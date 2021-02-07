import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photocontesthub/models/eventsModel.dart';
import 'package:photocontesthub/utils/Constants.dart';

class MyParticipationsEventCards extends StatelessWidget {
  final EventModels eventModel;

  const MyParticipationsEventCards({Key key, this.eventModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String time;
    try {
      time = DateFormat.yMMMMd('en_US')
          .add_E()
          .addPattern("${"@"}")
          .add_jm()
          .format(DateTime.parse(eventModel.time));
    } catch (error) {
      time = "${eventModel.time}";
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: <Widget>[
            Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                imageUrl: eventModel.eventImage,
                fit: BoxFit.fill,
                placeholder: (context, url) => Image.asset(Constants.gallery_placeholder),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Container(
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 20,
                      child: Text(
                        "CH",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "Photo Contest #${eventModel.eventId}",
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontStyle: FontStyle.normal),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Time: ${time}",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white, Colors.white])),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.red)),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 1),
                                  child: Text(
                                    "Winner Prize ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    "Rs ${eventModel.prize}+ Addons",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.red)),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    "Type ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    eventModel.type,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.red)),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    "Entry Fee ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    "${eventModel.entryFee}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                    ),
                  ]),
                )),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "You Have Successfully particiapted, Your Post will be visible in Our facebook Page on ${DateFormat.yMMMMd('en_US').add_E().addPattern("${"@"}").add_jm().format(DateTime.parse(eventModel.votingStartDate))} ",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: <Widget>[
                        Text(
                          "Voting Will start on -",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          " ${DateFormat.yMMMMd('en_US').add_E().addPattern("${"@"}").add_jm().format(DateTime.parse(eventModel.votingStartDate))}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Voting Will End on-",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          " ${DateFormat.yMMMMd('en_US').add_E().addPattern("${"@"}").add_jm().format(DateTime.parse(eventModel.votingEndDate))}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Result Date-",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          " ${DateFormat.yMMMMd('en_US').add_E().addPattern("${"@"}").add_jm().format(DateTime.parse(eventModel.resultDate))}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
