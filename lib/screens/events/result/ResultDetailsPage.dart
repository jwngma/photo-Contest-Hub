import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photocontesthub/models/AllParticiapantsModel.dart';
import 'package:photocontesthub/models/eventsModel.dart';
import 'package:photocontesthub/services/firestore_services.dart';
import 'package:photocontesthub/widgets/allParticipantsCard.dart';
import 'package:photocontesthub/widgets/showLoading.dart';

class ResultDetailsPage extends StatefulWidget {
  final EventModels eventsModel;

  const ResultDetailsPage({Key key, this.eventsModel}) : super(key: key);

  @override
  _ResultDetailsPageState createState() =>
      _ResultDetailsPageState(this.eventsModel);
}

class _ResultDetailsPageState extends State<ResultDetailsPage> {
  final EventModels eventModel;

  _ResultDetailsPageState(this.eventModel);

  Stream stream;
  FirestoreServices fireStoreServices = FirestoreServices();
  bool showLoading = false;
  bool resultAnnounced = false;

  @override
  void initState() {
    fireStoreServices.getAllParticipations(eventModel.eventId).then((val) {
      setState(() {
        stream = val;
        showLoading = false;
      });
    });
    super.initState();
  }

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Photo Contest Event #${eventModel.eventId}",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 1,
      ),
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Image.network(
                          eventModel.eventImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
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
                              padding: const EdgeInsets.only(top: 1),
                              child: AutoSizeText(
                                 "Theme- ${eventModel.title}",
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 20,
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
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 1),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blue)),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 1),
                                          child: Text(
                                            "1st Prize ",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.blue,
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
                                        border: Border.all(color: Colors.blue)),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            "Type ",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.blue,
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
                                        border: Border.all(color: Colors.blue)),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            "Entry Fee ",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.blue,
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
                            Text(
                              "Voting started at:${votingStartdate}",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                            Text(
                              "Voting Ends at:${votingEnddate}",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                            Text(
                              "Result date:Within 24 hrs after Voting Ends",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                          ]),
                        )),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.white, Colors.white])),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                        ]),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 5),
                            child: Text(
                              "Prizes",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "1. 1st Prize- Rs ${eventModel.prize} /-",
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              "2. 2nd Prize-  Rs ${eventModel.prizeTwo} /-",
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              "3. 3rd prize- Rs ${eventModel.prizeThree} /-",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  resultAnnounced
                      ? Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 5),
                                  child: Text(
                                    "Rusult",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Text(
                                  "Dummy Basumatary is the Winner",
                                  style: TextStyle(color: Colors.black),
                                ),
                              )
                            ],
                          ),
                        )
                      : SizedBox.shrink(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 5),
                            child: Text(
                              "All Particiapants",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'check the Likes, Comments, Share from the facebook Page ',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: StreamBuilder(
                                  stream: stream,
                                  builder: (context, snapshots) {
                                    switch (snapshots.connectionState) {
                                      case ConnectionState.waiting:
                                        print("waiting");
                                        return Center(
                                            child: CircularProgressIndicator());
                                        break;
                                      case ConnectionState.active:
                                        print("active");
                                        if (!snapshots.hasData) {
                                          return Text(
                                            "Empty",
                                            style: TextStyle(color: Colors.red),
                                          );
                                        } else {
                                          return ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: snapshots
                                                  .data.documents.length,
                                              itemBuilder: (context, index) {
                                                AllParticipantsModel
                                                    eventModels =
                                                    AllParticipantsModel(
                                                  facebook_name: snapshots
                                                      .data
                                                      .documents[index]
                                                      .data["facebook_name"],
                                                  id: snapshots
                                                      .data
                                                      .documents[index]
                                                      .data["id"],
                                                  post_id: snapshots
                                                      .data
                                                      .documents[index]
                                                      .data["post_id"],
                                                  name: snapshots
                                                      .data
                                                      .documents[index]
                                                      .data["name"],
                                                  image: snapshots
                                                      .data
                                                      .documents[index]
                                                      .data["image"],
                                                  winner: snapshots
                                                      .data
                                                      .documents[index]
                                                      .data["eventImage"],
                                                  winner_prize: snapshots
                                                      .data
                                                      .documents[index]
                                                      .data["status"],
                                                  uid: snapshots
                                                      .data
                                                      .documents[index]
                                                      .data["uid"],
                                                );
                                                return Card(
                                                    elevation: 10,
                                                    color: Colors.blueGrey,
                                                    child: AllParticipantsCard(
                                                        eventModels, index,eventModel.eventId.toString()));
                                              });
                                        }

                                        break;
                                      case ConnectionState.none:
                                        print("none");
                                        return Center(
                                            child: Text(
                                          "No Events",
                                          style: TextStyle(color: Colors.black),
                                        ));
                                        break;
                                      default:
                                        if (snapshots.hasError) {
                                          return Text(
                                              'Error: ${snapshots.error}');
                                        } else {
                                          return Text(
                                            'Button tapped ${snapshots.data} time${snapshots.data == 1 ? '' : 's'}.\n\n'
                                            'This should persist across restarts.',
                                            style: TextStyle(color: Colors.red),
                                          );
                                        }
                                    }
                                  }),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
          showLoading ? showLoadingDialog() : SizedBox.shrink(),
        ],
      ),
    );
  }
}
