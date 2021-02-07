import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photocontesthub/models/eventsModel.dart';
import 'package:photocontesthub/utils/Constants.dart';

class EventCards extends StatelessWidget {
  final EventModels eventModel;

  const EventCards({Key key, this.eventModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String time, votingStartdate, votingEnddate;
    try {
      time = DateFormat.yMMMMd('en_US')
          .add_E()
          .addPattern("${"@"}")
          .add_jm()
          .format(DateTime.parse(eventModel.time));
      votingStartdate = DateFormat.yMMMMd('en_US')
          .add_E()
          .addPattern("${"@"}")
          .add_jm()
          .format(DateTime.parse(eventModel.votingStartDate));
      votingEnddate = DateFormat.yMMMMd('en_US')
          .add_E()
          .addPattern("${"@"}")
          .add_jm()
          .format(DateTime.parse(eventModel.votingEndDate));
    } catch (error) {
      time = "${eventModel.time}";
      votingStartdate = "${eventModel.votingStartDate}";
      votingEnddate = "${eventModel.votingEndDate}";
    }

    String calDiscount() {
      String returnStr;
      double discount = 0.0;
      returnStr = discount.toString();

      discount =
          (int.parse(eventModel.totalSlots) - eventModel.totalParticipated) /
              100;
      returnStr = discount.toStringAsFixed(1);

      return returnStr ;
    }

    return Center(
      child: Padding(
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
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Image.asset(Constants.gallery_placeholder),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                /* Image.network(
                  eventModel.eventImage,
                  fit: BoxFit.fill,
                ),*/
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
                          "PCH",
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
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 1),
                            child: AutoSizeText(
                              "Theme- ${eventModel.title}",
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FontStyle.normal),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 1),
                            child: Text(
                              "Photo Contest #${eventModel.eventId}",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FontStyle.normal),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AutoSizeText(
                      "Voting Starts at: $votingStartdate",
                      maxLines: 1,
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  )),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 1),
                                    child: Text(
                                      "1st Prize ",
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
                                      "Rs ${eventModel.prize}",
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Slider(
                                      value: double.parse(eventModel
                                          .totalParticipated
                                          .toString()),
                                      onChanged: (value) {},
                                      max: double.parse(eventModel.totalSlots),
                                    ),
                                    eventModel.status == "Upcoming"
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "${(100-(eventModel.totalParticipated/int.parse(eventModel.totalSlots))*100)} %",
                                              //  "${int.parse(eventModel.totalSlots) - eventModel.totalParticipated}",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              AutoSizeText(
                                                " Spots left",
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 5),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              )
                                            ],
                                          )
                                        : SizedBox.shrink()
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "${(eventModel.totalParticipated/int.parse(eventModel.totalSlots))*100} %",
                                   // calDiscount(),
                                    //   "${eventModel.totalParticipated}",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                  Text(
                                    "/",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  AutoSizeText(
                                    " 100",
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.red),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AutoSizeText(
                                  eventModel.status == "Upcoming"
                                      ? "Join"
                                      : "show",
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
