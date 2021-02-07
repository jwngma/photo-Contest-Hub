import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:photocontesthub/models/eventsModel.dart';
import 'package:photocontesthub/models/postResponse.dart';
import 'package:photocontesthub/models/transactions.dart';
import 'package:photocontesthub/models/users.dart';
import 'package:photocontesthub/utils/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirestoreServices {
  Firestore _db = Firestore.instance;

  Future<void> addEvents(EventModels eventModels) async {
    var respectsQuery = await _db.collection("Events");
    var querySnapshot = await respectsQuery.getDocuments();
    var totalevents = querySnapshot.documents.length + 1;

    var data = Map<String, dynamic>();
    data['eventId'] = totalevents + 1;
    data['title'] = eventModels.title;
    data['time'] = eventModels.time;
    data['status'] = eventModels.status;
    data['eventImage'] = eventModels.eventImage;
    data['type'] = eventModels.type;
    data['entryFee'] = eventModels.entryFee;
    data['votingStartDate'] = eventModels.votingStartDate;
    data['votingEndDate'] = eventModels.votingEndDate;
    data['resultDate'] = eventModels.resultDate;
    data['prize'] = eventModels.prize;
    data['totalParticipated'] = eventModels.totalParticipated;
    data['totalSlots'] = eventModels.totalSlots;

    await _db
        .collection("Events")
        .document("Event${totalevents + 1}")
        .setData(data)
        .then((value) async {
      await _db
          .collection("Participations")
          .document("Event${totalevents + 1}")
          .setData(data);
    });
  }


  Future<List<DocumentSnapshot>> getEvents(
    String status,
  ) async {
    List<DocumentSnapshot> _list = [];
    Query query = _db
        .collection(Constants.Events)
        .where('status', isEqualTo: status)
        .orderBy("time", descending: false);
    QuerySnapshot querySnapshot = await query.getDocuments();
    _list = querySnapshot.documents;

    return _list;
  }

//
  //get All the particiapants Images from the event participations
  Future<Stream<QuerySnapshot>> getAllParticipations(int eventid) async {
    return await _db
        .collection("Events")
        .document('Event${eventid}')
        .collection('participants')
        .snapshots();
  }

  // to check if user already participated// get the name of user particiaped
  Future<bool> getUserAlreadyparticipated(EventModels eventModels) async {
    List<dynamic> usersList = [];
    bool participated = false;
    await _db
        .collection("Participations")
        .document("Event${eventModels.eventId}")
        .get()
        .then((DocumentSnapshot) => DocumentSnapshot.data['participants'])
        .then((value) {
      print(value);
      usersList = value;
      if (usersList != null) {
        if (usersList.contains(Constants.prefs.getString(Constants.uid))) {
          print("User Already Participated");
          participated = true;
        } else {
          print("Have to aprticipated");
          participated = false;
        }
      } else {
        print("No Paticipants yet");
        participated = false;
      }
    });

    return participated;
  }

  //drawer my particapition
  Future getMyParticipationsEvents() async {
    return await _db
        .collection("Participations")
        .where('participants', arrayContains: Constants.prefs.getString("uid"))
        .orderBy("time", descending: true)
        .snapshots();
  }

  // getting Notifications
  getNotifications() async {
    return await _db
        .collection("Notifications")
        .orderBy("time", descending: false)
        .snapshots();
  }

  // getting the partipated user from the Eg Solo/ gameID/Paticipants
  getparticipatedusers(String gameType, String gameId) async {
    return await _db
        .collection(gameType)
        .document(gameId)
        .collection("participants")
        .snapshots();
  }

  // getting the partipated user from the Eg Solo/ gameID/Paticipants
  getWinnerfortheEndedmatches(String gameType, String gameId) async {
    return await _db
        .collection(gameType)
        .document(gameId)
        .collection("winners")
        .snapshots();
  }

//  // getting transaction done by the user
//  getTransactions() async {
//    return await _db
//        .collection(PhotoContestHub.Users)
//        .document(PhotoContestHub.prefs.getString(PhotoContestHub.uid))
//        .collection("transactions")
//        .snapshots();
//  }

  // getting transaction done by the user
  Future<List<DocumentSnapshot>> getTransactions() async {
    List<DocumentSnapshot> _list = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Query query = _db
        .collection(Constants.Users)
        .document(prefs.getString(Constants.uid))
        .collection("transactions");
    QuerySnapshot querySnapshot = await query.getDocuments();
    _list = querySnapshot.documents;

    return _list;
  }

  Future<int> getAmount(FirebaseUser currentUser) async {
    return await _db
        .collection(Constants.Users)
        .document(currentUser.uid)
        .get()
        .then((DocumentSnapshot) => DocumentSnapshot.data['amount']);
  }

  Future getName(FirebaseUser currentUser) async {
    return await _db
        .collection(Constants.Users)
        .document(currentUser.uid)
        .get()
        .then((DocumentSnapshot) => DocumentSnapshot.data['name']);
  }

  Future getFacebookName(FirebaseUser currentUser) async {
    return await _db
        .collection(Constants.Users)
        .document(currentUser.uid)
        .get()
        .then((DocumentSnapshot) => DocumentSnapshot.data['facebook_name']);
  }

  Future<Users> getUserprofile() async {
    return await _db
        .collection(Constants.Users)
        .document(Constants.prefs.getString(Constants.uid))
        .get()
        .then((DocumentSnapshot) => Users.fromMap(DocumentSnapshot.data));
  }

  Future<void> addTransactions(
    BuildContext context,
    Transactions transactionsModel,
    String uid,
  ) async {
    //update to user Database
    int amount = int.parse("${transactionsModel.amount.toString()}");

    await _db.collection(Constants.Users).document(uid).updateData({
      "amount": FieldValue.increment(amount),
    }).then((val) async {
      //getting the trans count
      int transaction_number = await _db
          .collection("Transactions")
          .document("transactions_count")
          .get()
          .then((DocumentSnapshot) => DocumentSnapshot.data['count']);

      print(" Trans Count: ${transaction_number.toString()}");

      //save the transactions record for the user
      var transMap = Map<String, dynamic>();
      transMap["id"] = (transaction_number + 1);
      transMap["txnId"] = transactionsModel.txnId;
      transMap["status"] = transactionsModel.status;
      transMap["responseCode"] = transactionsModel.responseCode;
      transMap["referenceId"] = transactionsModel.referenceId;
      transMap["approvalNo"] = transactionsModel.approvalNo;
      transMap["title"] = transactionsModel.title;
      transMap["amount"] = transactionsModel.amount;
      transMap["type"] = transactionsModel.type;
      transMap["time"] = transactionsModel.time;

      await _db
          .collection(Constants.Users)
          .document(uid)
          .collection("transactions")
          .document(transactionsModel.txnId)
          .setData(transMap)
          .then((value) async {
        print("transactions Updated");
        await _db
            .collection("Transactions")
            .document("transactions_count")
            .updateData({
          "count": FieldValue.increment(1),
        }).then((val) {
          print("transactions Count Updated");
        }).catchError((error) {
          _showError(context);
        });
        ;
      });
    });
  }

  // Failed Tranaction
  Future<void> addFailedTransactions(
    BuildContext context,
    Transactions transactionsModel,
    String uid,
  ) async {
    int amount = int.parse("${transactionsModel.amount.toString()}");

    //save the transactions record for the user
    var transMap = Map<String, dynamic>();
    transMap["txnId"] = transactionsModel.txnId;
    transMap["status"] = transactionsModel.status;
    transMap["responseCode"] = transactionsModel.responseCode;
    transMap["referenceId"] = transactionsModel.referenceId;
    transMap["approvalNo"] = transactionsModel.approvalNo;
    transMap["title"] = transactionsModel.title;
    transMap["amount"] = transactionsModel.amount;
    transMap["type"] = transactionsModel.type;
    transMap["time"] = transactionsModel.time;

    await _db
        .collection(Constants.Users)
        .document(uid)
        .collection("transactions")
        .document(transactionsModel.txnId)
        .setData(transMap)
        .then((value) async {
      print(" failed transactions Updated");
    }).catchError((error) {
      _showError(context);
    });
    ;
  }

  //Withdraw
  Future<void> addWithdrawRequest(
      BuildContext context, String method, int amount, String number) async {
    //update to user Database

    String uid = await Constants.prefs.getString(Constants.uid);
    await _db.collection(Constants.Users).document(uid).updateData({
      "amount": FieldValue.increment(-amount),
    }).then((val) async {
      //save the transactions in Withdraw Request
      var withdrawMap = Map<String, dynamic>();
      withdrawMap["amount"] = amount;
      withdrawMap["time"] = DateTime.now().toIso8601String();
      withdrawMap["method"] = method;
      withdrawMap["status"] = "pending";
      withdrawMap["number"] = number;
      withdrawMap["uid"] = uid;
      withdrawMap["title"] = "Withdraw";

      String docId = uid + "${DateTime.now().toIso8601String()}";
      await _db
          .collection("WithdrawRequest")
          .document(docId)
          .setData(withdrawMap)
          .then((value) async {
        await _db
            .collection(Constants.Users)
            .document(uid)
            .collection("transactions")
            .document(docId)
            .setData(withdrawMap)
            .then((value) {})
            .then((val) {
          print("Withdraw Request have been added");
        });
      }).catchError((error) {
        _showError(context);
      });
      ;
    });
  }

  //Update Profile
  Future<void> updateUserProfile(BuildContext context, Users user) async {
    //update to user Database
    String uid = await Constants.prefs.getString(Constants.uid);
    var userMap = Map<String, dynamic>();
    userMap['name'] = user.name;
    userMap['facebook_name'] = user.facebook_name;
    userMap['phone_number'] = user.phone_number;

    await _db
        .collection(Constants.Users)
        .document(uid)
        .updateData(userMap)
        .then((val) {
      print("User profile Updated");
    }).catchError((error) {
      _showError(context);
    });
    ;
  }

  //Update PostLink
  Future<void> updatePostLink(
    BuildContext context,
    String url,
    EventModels eventModels,
    FirebaseUser user,
  ) async {
    //update Facebook Post Id to Event paticipated database
    var userMap = Map<String, dynamic>();
    userMap['url'] = url;
    userMap['likes'] = 0;
    userMap['createdTime'] = FieldValue.serverTimestamp();
    userMap['likers'] = FieldValue.arrayUnion(['']);
    userMap['name'] = user.displayName;
    userMap['uid'] = user.uid;

    await _db
        .collection("Events")
        .document("Event${eventModels.eventId}")
        .collection("participants")
        .document(user.uid)
        .setData(userMap)
        .then((val) {
      print("User Facebook Post Link Updated");
    }).catchError((error) {
      _showError(context);
    });
    ;
  }

//Like The Post
  Future<bool> likePost(
      BuildContext context, String eventId, String uid) async {
    var userMap = Map<String, dynamic>();
    userMap['likes'] = FieldValue.increment(1);
    userMap['likers'] = FieldValue.arrayUnion([uid]);

    await _db
        .collection("Events")
        .document("Event${eventId}")
        .collection("participants")
        .document(uid)
        .updateData(userMap)
        .then((value) {
      return true;
    }).catchError((error) {
      print("${error}");
      _showError(context);
    });
  }

  //UnLike The Post
  Future<void> unlikePost(
      BuildContext context, String eventId, String uid) async {
    var userMap = Map<String, dynamic>();
    userMap['likes'] = FieldValue.increment(-1);
    userMap['participants'] = FieldValue.arrayRemove([uid]);

    await _db
        .collection("Events")
        .document("Event${eventId}")
        .collection("participants")
        .document(uid)
        .updateData(userMap)
        .then((value) {
      print("Removed Liked");
    }).catchError((error) {
      _showError(context);
    });
  }

/* participate user*/
  Future<void> participate(EventModels eventModels, String facebookName,
      FirebaseUser user, int amount, BuildContext context) async {
    var respectsQuery = await _db
        .collection("Events")
        .document("Event${eventModels.eventId}")
        .collection("participants");
    var querySnapshot = await respectsQuery.getDocuments();
    var total_participated = querySnapshot.documents.length;
    print("Total" + total_participated.toString());

    if (total_participated < int.parse(eventModels.totalSlots)) {
      //decr amount from wallet
      await _db
          .collection(Constants.Users)
          .document(user.uid)
          .updateData({
            "amount": FieldValue.increment(-amount),
          })
          .then((value) async {
            print("Deceremnted");
            await _db
                .collection("Participations")
                .document("Event${eventModels.eventId.toString()}")
                .updateData({
              "totalParticipated": FieldValue.increment(1),
            }).then((value) async {
              await _db
                  .collection("Participations")
                  .document("Event${eventModels.eventId}")
                  .updateData({
                "participants": FieldValue.arrayUnion([user.uid])
              }).then((val) async {
                await _db
                    .collection("Events")
                    .document("Event${eventModels.eventId.toString()}")
                    .updateData({
                  "totalParticipated": FieldValue.increment(1),
                });
              });
            });
          })
          .timeout(Duration(seconds: 20))
          .catchError((error) {
            _showError(context, error);
          });
    } else {
      showToast(
          "We have Reched The Max Limit, Please participate in the next Event",
          context: context,
          backgroundColor: Colors.green,
          duration: Duration(seconds: 5),
          position: StyledToastPosition(align: Alignment.center, offset: 20.0));
    }
  }
}

_showDoneMessage(
  BuildContext context,
) {
  showToast("You have Paticipated Successfully",
      context: context,
      backgroundColor: Colors.green,
      duration: Duration(seconds: 5),
      position: StyledToastPosition(align: Alignment.center, offset: 20.0));
}

_showError(BuildContext context, [Error error]) {
  showToast("Error Occured, Please Try Again",
      context: context,
      backgroundColor: Colors.green,
      duration: Duration(seconds: 5),
      position: StyledToastPosition(align: Alignment.center, offset: 20.0));
}
