import 'dart:async';

//import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:photocontesthub/inapp_purchase/CoinStorePage.dart';
import 'package:photocontesthub/utils/Constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/config_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  Constants.prefs = await SharedPreferences.getInstance();
  InAppPurchaseConnection.enablePendingPurchases();
  runApp(ConfigPage());
}

