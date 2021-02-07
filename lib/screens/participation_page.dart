import 'package:flutter/material.dart';
import 'package:photocontesthub/models/eventsModel.dart';
import 'package:photocontesthub/services/firestore_services.dart';
import 'package:photocontesthub/widgets/my_participation_card.dart';

class MyParticipationsPage extends StatefulWidget {
  @override
  _MyParticipationsPageState createState() => _MyParticipationsPageState();
}

class _MyParticipationsPageState extends State<MyParticipationsPage> {
  Stream stream;
  FirestoreServices fireStoreServices = FirestoreServices();

  @override
  void initState() {
    fireStoreServices.getMyParticipationsEvents().then((val) {
      setState(() {
        stream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Participations"),
        ),
        backgroundColor: Colors.white,
        body: StreamBuilder(
            stream: stream,
            builder: (context, snapshots) {
              return snapshots.data == null
                  ? Container(
                      child: Center(
                          child: CircularProgressIndicator(
                        backgroundColor: Colors.red,
                      )),
                    )
                  : ListView.builder(
                      itemCount: snapshots.data.documents.length,
                      itemBuilder: (context, index) {
                        EventModels eventModel = EventModels(
                          title: snapshots.data.documents[index].data["title"],
                          eventId:
                              snapshots.data.documents[index].data["eventId"],
                          status:
                              snapshots.data.documents[index].data["status"],
                          type: snapshots.data.documents[index].data["type"],
                          entryFee:
                              snapshots.data.documents[index].data["entryFee"],
                          prize: snapshots.data.documents[index].data["prize"],
                          votingStartDate: snapshots
                              .data.documents[index].data["votingStartDate"],
                          resultDate: snapshots
                              .data.documents[index].data["resultDate"],
                          votingEndDate: snapshots
                              .data.documents[index].data["votingEndDate"],
                          totalParticipated: snapshots
                              .data.documents[index].data["totalParticipated"],
                          eventImage: snapshots
                              .data.documents[index].data["eventImage"],
                          time: snapshots
                              .data.documents[index].data["time"],
                          prizeTwo: snapshots
                              .data.documents[index].data["prizeTwo"],
                          prizeThree: snapshots
                              .data.documents[index].data["prizeThree"],
                          prizeFour: snapshots
                              .data.documents[index].data["prizeFour"],
                          totalSlots: snapshots
                              .data.documents[index].data["totalPlayer"],
                        );
                        return Card(
                            elevation: 10,
                            color: Colors.green,
                            child: MyParticipationsEventCards(
                              eventModel: eventModel,
                            ));
                      });
            }));
  }
}
