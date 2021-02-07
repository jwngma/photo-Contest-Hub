import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:intl/intl.dart';
import 'package:photocontesthub/models/eventsModel.dart';
import 'package:photocontesthub/screens/participate_page.dart';
import 'package:photocontesthub/services/firebase_auth_services.dart';
import 'package:photocontesthub/services/firestore_services.dart';
import 'package:photocontesthub/utils/Constants.dart';
import 'package:photocontesthub/widgets/message_dialog_with_ok.dart';
import 'package:photocontesthub/widgets/showLoading.dart';
import 'package:provider/provider.dart';


class EventDetailsPage extends StatefulWidget {
  final EventModels eventsModel;

  const EventDetailsPage({Key key, this.eventsModel}) : super(key: key);

  @override
  _EventDetailsPageState createState() =>
      _EventDetailsPageState(this.eventsModel);
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  final EventModels eventModel;

  _EventDetailsPageState(this.eventModel);

  Stream stream;
  FirestoreServices fireStoreServices = FirestoreServices();
  bool showLoading = false;
  bool userparticipated = false;

  @override
  void initState() {
    super.initState();
    checkIfParticipatedAlready();
  }

  checkIfParticipatedAlready() async {
    userparticipated =
        await fireStoreServices.getUserAlreadyparticipated(eventModel);
    if (userparticipated) {
      setState(() {
        showLoading = false;
        print("particated");
      });
    } else {
      setState(() {
        showLoading = false;
        print("Not particated");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final firestore = Provider.of<FirestoreServices>(context, listen: false);
    final auth = Provider.of<FirebaseAuthServices>(context, listen: false);

    Widget _buildRules(int index) {
      return Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                Constants.match_rules[index],
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      );
    }

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
    print("Time: $time");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Photo Contest Event #${eventModel.eventId}",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 1,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: userparticipated ? Colors.black : Colors.red,
        //onPressed: !userparticipated ? _participateTheUser : null,
        onPressed: () {
          !userparticipated
              ? Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ParticipatePage(
                    eventModels: eventModel,
                  );
                }))
              : null;
        },
        isExtended: true,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        icon: Icon(
          Icons.videogame_asset,
          color: Colors.white,
        ),
        label: Text(
          userparticipated ? "Participated" : "Particpate",
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue)),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          "Registration Start- ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: AutoSizeText(
                                          "${time}",
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 10,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          "Voting Starts- ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: AutoSizeText(
                                          "${votingStartdate}",
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          "Voting Ends At- ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: AutoSizeText(
                                          "${votingEnddate}",
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Slider(
                                            value: double.parse(eventModel
                                                .totalParticipated
                                                .toString()),
                                            onChanged: (value) {},
                                            max: double.parse(
                                                eventModel.totalSlots),
                                          ),
                                          eventModel.status == "Upcoming"
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      "${(100-(eventModel.totalParticipated/int.parse(eventModel.totalSlots))*100)} %",
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                    AutoSizeText(
                                                      " Spots left",
                                                      textAlign:
                                                          TextAlign.center,
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
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          "/",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        AutoSizeText(
                                          "100 %",
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Rules to Follow",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: Constants.match_rules
                          .asMap()
                          .entries
                          .map((MapEntry map) => _buildRules(map.key))
                          .toList(),
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
