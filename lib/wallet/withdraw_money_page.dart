import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:photocontesthub/wallet/withdraw_page.dart';
import 'package:photocontesthub/services/firebase_auth_services.dart';
import 'package:photocontesthub/services/firestore_services.dart';

class WithdrawMoney extends StatefulWidget {
  const WithdrawMoney({
    Key key,
  }) : super(key: key);

  @override
  _WithdrawMoneyState createState() => _WithdrawMoneyState();
}

class _WithdrawMoneyState extends State<WithdrawMoney> {
  FirestoreServices fireStoreServices = FirestoreServices();
  FirebaseAuthServices authServices = FirebaseAuthServices();

  @override
  void initState() {
    super.initState();
    _getBalance();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  int amount;

  _getBalance() async {
    int amountt =
        await fireStoreServices.getAmount(await authServices.getCurrentUser());
    setState(() {
      amount = amountt;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
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
                                amount == 0 ? "0" : "Rs- ${amount}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            )
                          ],
                        ),
                      ),
                      Text(
                        amount == 0 ? "Wait For Few Seconds To get loaded" : "",
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Select Mode to Withdraw Money",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue),
                  child: FlatButton(
                    onPressed: () {
                      if (amount >= 200) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return WithdrawPage(
                            payment_method: "paytm",
                          );
                        }));
                      } else {
                        showToast(
                            "You have Low Balance in your wallet, Min Withdraw amount is 200",
                            context: context,
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 5),
                            position: StyledToastPosition(
                                align: Alignment.center, offset: 20.0));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Paytm",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue),
                  child: FlatButton(
                    onPressed: () {
                      if (amount >= 200) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return WithdrawPage(
                            payment_method: "Google pay",
                          );
                        }));
                      } else {
                        showToast(
                            " You have Low Balance in your wallet, Min Withdraw amount is 200",
                            context: context,
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 5),
                            position: StyledToastPosition(
                                align: Alignment.center, offset: 20.0));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Google pay",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue),
                  child: FlatButton(
                    onPressed: () {
                      if (amount >= 200) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return WithdrawPage(
                            payment_method: "Phonepe",
                          );
                        }));
                      } else {
                        showToast(
                            "You have Low Balance in your wallet, Min Withdraw amount is 200",
                            context: context,
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 5),
                            position: StyledToastPosition(
                                align: Alignment.center, offset: 20.0));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Phonepe",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Note- You Will receive your payment within 48 hours",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
