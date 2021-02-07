//import 'package:auto_size_text/auto_size_text.dart';
//import 'package:flutter/material.dart';
//import 'package:photocontesthub/models/transactions.dart';
//import 'package:photocontesthub/screens/wallet_page.dart';
//import 'package:photocontesthub/services/firestore_services.dart';
//import 'package:photocontesthub/utils/Constants.dart';
//import 'package:photocontesthub/widgets/message_dialog_with_ok.dart';
//import 'package:progress_dialog/progress_dialog.dart';
//import 'package:upi_india/upi_india.dart';
//import 'package:upi_india/upi_response.dart';
//
//class PaymentPage extends StatefulWidget {
//  final double amount;
//
//  const PaymentPage({Key key, @required this.amount}) : super(key: key);
//
//  @override
//  _PaymentPageState createState() => _PaymentPageState(this.amount);
//}
//
//class _PaymentPageState extends State<PaymentPage> {
//  final double amount;
//
//  _PaymentPageState(this.amount);
//
//  FirestoreServices fireStoreServices = FirestoreServices();
//
//  Future<UpiResponse> _transaction;
//  UpiIndia _upiIndia = UpiIndia();
//  List<UpiApp> apps;
//  bool showBack = true;
//
//  @override
//  void initState() {
//    _upiIndia.getAllUpiApps().then((value) {
//      setState(() {
//        apps = value;
//      });
//    });
//    super.initState();
//  }
//
//  Future<UpiResponse> initiateTransaction(String app) async {
//    return _upiIndia.startTransaction(
//      app: app,
//      receiverUpiId: 'smkbty@oksbi',
//      receiverName: 'Jwngma basumatary',
//      transactionRefId: 'JwngmaId',
//      transactionNote: 'Payment to Photo Contest Hub',
//      amount: amount,
//    );
//  }
//
//  Widget displayUpiApps() {
//    if (apps == null)
//      return Center(child: CircularProgressIndicator());
//    else if (apps.length == 0)
//      return Center(child: Text("No apps found to handle transaction."));
//    else
//      return Center(
//        child: Wrap(
//          children: apps.map<Widget>((UpiApp app) {
//            return GestureDetector(
//              onTap: () {
//                _transaction = initiateTransaction(app.app).then((value) {
//                  String txnId = value.transactionId;
//                  String resCode = value.responseCode;
//                  String txnRef = value.transactionRefId;
//                  String status = value.status;
//                  String approvalRef = value.approvalRefNo;
//                  switch (status) {
//                    case UpiPaymentStatus.SUCCESS:
//                      Transactions transactions = Transactions(
//                          id: "",
//                          txnId: txnId,
//                          status: status,
//                          responseCode: resCode,
//                          referenceId: txnRef,
//                          approvalNo: approvalRef,
//                          time: DateTime.now().toIso8601String(),
//                          amount: amount
//                              .toString()
//                              .substring(0, amount.toString().indexOf('.')),
//                          type: "Deposit",
//                          title: "Deposit");
//                      _addToDb(transactions);
//                      break;
//                    case UpiPaymentStatus.SUBMITTED:
//                      print('Transaction Submitted');
//                      break;
//                    case UpiPaymentStatus.FAILURE:
//                      print('Transaction Failed');
//                      Transactions failed_transactions = Transactions(
//                          id: "",
//                          txnId: txnId,
//                          status: status,
//                          responseCode: resCode,
//                          referenceId: txnRef,
//                          approvalNo: approvalRef,
//                          time: DateTime.now().toIso8601String(),
//                          amount: amount
//                              .toString()
//                              .substring(0, amount.toString().indexOf('.')),
//                          type: "Deposit",
//                          title: "Deposit");
//                      _addFailedTransactionToDb(failed_transactions);
//                      break;
//                    default:
//                      print('Received an Unknown transaction status');
//                  }
//                });
//                ;
//                setState(() {});
//              },
//              child: Container(
//                height: 100,
//                width: 100,
//                child: Column(
//                  mainAxisSize: MainAxisSize.min,
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Image.memory(
//                      app.icon,
//                      height: 60,
//                      width: 60,
//                    ),
//                    Text(app.name),
//                  ],
//                ),
//              ),
//            );
//          }).toList(),
//        ),
//      );
//  }
//
//  _addToDb(Transactions transactions) async {
//    ProgressDialog progressDialog =
//        ProgressDialog(context, isDismissible: false);
//    await progressDialog.show();
//    await fireStoreServices
//        .addTransactions(context, transactions,
//            PhotoContestHub.prefs.getString(PhotoContestHub.uid))
//        .then((val) {
//      progressDialog.hide();
//      showDialog(
//          context: context,
//          builder: (context) => CustomDialogWithOk(
//                title: "Transaction Successfull",
//                description: "Your Amount Has Been Addedd Successfully",
//                primaryButtonText: "Ok",
//                primaryButtonRoute: WalletScreen.routeName,
//              ));
//    });
//  }
//
//  _addFailedTransactionToDb(Transactions transactions) async {
//    ProgressDialog progressDialog =
//        ProgressDialog(context, isDismissible: false);
//    await progressDialog.show();
//    await fireStoreServices
//        .addFailedTransactions(context, transactions,
//            PhotoContestHub.prefs.getString(PhotoContestHub.uid))
//        .then((val) {
//      progressDialog.hide();
//      showDialog(
//          context: context,
//          builder: (context) => CustomDialogWithOk(
//                title: "Transaction failed",
//                description:
//                    "Your Transactions has Failed, Please Try Again With Another method",
//                primaryButtonText: "Ok",
//                primaryButtonRoute: WalletScreen.routeName,
//              ));
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return WillPopScope(
//      onWillPop: () async => false,
//      child: Scaffold(
//        appBar: AppBar(
//          title: Text("Photo Contest Hub Payment"),
//          centerTitle: true,
//          automaticallyImplyLeading: false,
//        ),
//        body: Padding(
//          padding: const EdgeInsets.all(15.0),
//          child: Column(
//            children: <Widget>[
//              SizedBox(
//                height: 20,
//              ),
//              AutoSizeText(
//                "We Support only Payments using UPI, Choose any of the Following",
//                textAlign: TextAlign.center,
//                style: TextStyle(fontSize: 22),
//              ),
//              SizedBox(
//                height: 10,
//              ),
//              displayUpiApps(),
//              !showBack
//                  ? SizedBox.shrink()
//                  : Container(
//                      width: MediaQuery.of(context).size.width * 0.7,
//                      decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(10),
//                          color: Colors.red),
//                      child: FlatButton(
//                          child: Padding(
//                            padding: const EdgeInsets.all(8.0),
//                            child: Text(
//                              "Back",
//                              style: TextStyle(color: Colors.white),
//                            ),
//                          ),
//                          onPressed: () {
//                            Navigator.pop(context);
//                          }),
//                    ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}
