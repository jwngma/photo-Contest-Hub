import 'dart:math';
import 'package:photocontesthub/services/firebase_auth_services.dart';
import 'package:photocontesthub/services/firestore_services.dart';
import 'package:photocontesthub/utils/tools.dart';
import 'package:photocontesthub/wallet/add_money_page.dart';
import 'package:photocontesthub/wallet/payment_page.dart';
import 'package:photocontesthub/wallet/transaction_page.dart';
import 'package:photocontesthub/wallet/withdraw_money_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WalletScreen extends StatefulWidget {
  static const String routeName = "/WalletScreen";

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  FirestoreServices firestoreServices = FirestoreServices();
  FirebaseAuthServices authServices = FirebaseAuthServices();
  int amount = 0;

  @override
  void initState() {
    super.initState();
    _getBalance();
  }

  _getBalance() async {
    int amountt =
        await firestoreServices.getAmount(await authServices.getCurrentUser());
    setState(() {
      amount = amountt;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Wallet"),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Tools.multiColors[Random().nextInt(4)],
            labelStyle: TextStyle(
              fontSize: 12,
            ),
            isScrollable: false,
            tabs: <Widget>[
              Tab(
                child: Text(
                  "Add Money",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                ),
                icon: Icon(
                  Icons.account_balance,
                  size: 18,
                ),
              ),
              Tab(
                child: Text("Withdraw",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
                icon: Icon(
                  FontAwesomeIcons.dollarSign,
                  size: 18,
                ),
              ),
              Tab(
                child: Text("Transations",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
                icon: Icon(
                  FontAwesomeIcons.moneyBillAlt,
                  size: 18,
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            AddMoney(),
            WithdrawMoney(),
            TransactionsPage()
          ],
        ),
      ),
    );
  }
}
