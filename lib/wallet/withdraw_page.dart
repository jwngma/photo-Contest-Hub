import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:photocontesthub/screens/home_page.dart';
import 'package:photocontesthub/services/firebase_auth_services.dart';
import 'package:photocontesthub/services/firestore_services.dart';
import 'package:photocontesthub/widgets/message_dialog_with_ok.dart';
import 'package:progress_dialog/progress_dialog.dart';

class WithdrawPage extends StatefulWidget {
  final String payment_method;

  const WithdrawPage(
      {Key key, @required this.payment_method})
      : super(key: key);

  @override
  _WithdrawPageState createState() =>
      _WithdrawPageState( this.payment_method);
}

class _WithdrawPageState extends State<WithdrawPage> {
  FirestoreServices fireStoreServices = FirestoreServices();
  FirebaseAuthServices authServices = FirebaseAuthServices();
  int amount;
  final String payment_method;

  TextEditingController _amountController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _codeController = TextEditingController();

  _WithdrawPageState( this.payment_method);

  _addWithdraw(int amount, String number, String method,
      ProgressDialog progressDialog) async {
    progressDialog.show();
    await fireStoreServices
        .addWithdrawRequest(context, method, amount, number)
        .then((val) {
      progressDialog.hide();

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => CustomDialogWithOk(
                title: "Withdraw Requested",
                description:
                    "Your request will be processed within 24 to 48 hrs",
                primaryButtonText: "Ok",
                primaryButtonRoute: HomePage.routeName,
              ));
    });
  }

  showToastt(String message) {
    showToast(message,
        context: context,
        backgroundColor: Colors.green,
        duration: Duration(seconds: 5),
        position: StyledToastPosition(align: Alignment.center, offset: 20.0));
  }

  @override
  void initState() {
    _getBalance();
    super.initState();
  }

  _getBalance() async {
    int amountt =
    await fireStoreServices.getAmount(await authServices.getCurrentUser());
    setState(() {
      amount = amountt;
    });
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog progressDialog =
        ProgressDialog(context, isDismissible: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Withdraw"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey),
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                                child: Text(
                              "Available Balance:",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )),
                            SizedBox(
                              width: 10,
                            ),
                            Center(
                              child: Text(
                                amount == 0 ? "Loading.." : "Rs-${amount}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Text(
                      "Enter Your Details",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration:
                            InputDecoration(labelText: "Enter The Amount"),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: TextField(
                              controller: _codeController,
                              keyboardType: TextInputType.text,
                              maxLength: 3,
                              decoration: InputDecoration(
                                  labelText: "Code", hintText: "+91"),
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child: TextField(
                              controller: _numberController,
                              maxLength: 10,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: "Enter The Number"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red),
                        child: FlatButton(
                          onPressed: () {
                            if (_amountController.text.toString() != null &&
                                _amountController.text.toString() != "") {
                              int withdraw_amount =
                                  int.parse(_amountController.text.toString());
                              if (withdraw_amount >= 200) {
                                if (_codeController.text.toString() != null &&
                                    _codeController.text.toString() != "") {
                                  if (amount >=
                                      int.parse(
                                          _amountController.text.toString())) {
                                    if (_numberController.text
                                                .toString()
                                                .length <
                                            10 ||
                                        _numberController.text
                                                .toString()
                                                .length >
                                            10) {
                                      showToastt(
                                          "Your Mobile Number is Too Short");
                                    } else {
                                      _addWithdraw(
                                          int.parse(_amountController.text
                                              .toString()),
                                          _codeController.text.toString() +
                                              _numberController.text.toString(),
                                          payment_method,
                                          progressDialog);
                                    }
                                  } else {
                                    showToastt(
                                        "Withdraw Amount Cannot be Greater Than Balance Amount");
                                  }
                                } else {
                                  showToastt("Enter The Country Code");
                                }
                              } else {
                                showToastt("Minimum Withdrawal Amount is 200");
                              }
                            } else {
                              showToastt("Enter Your Amount");
                            }
                          },
                          child: Text(
                            "Withdraw",
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "We Support payments only using Upi, If You do not have upi apps like Paytm, google Pay, phonepe etc, Please install first",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
