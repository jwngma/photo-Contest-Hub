import 'package:provider/provider.dart';
import 'package:photocontesthub/screens/help_page.dart';
import 'package:photocontesthub/screens/participation_page.dart';
import 'package:photocontesthub/screens/policy_page.dart';
import 'package:photocontesthub/screens/profile_page.dart';
import 'package:photocontesthub/screens/wallet_page.dart';
import 'package:photocontesthub/services/firebase_auth_services.dart';
import 'package:photocontesthub/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:share/share.dart';

class AccountScreen extends StatefulWidget {
  static const String routeName = "/accountScreen";

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {


  bool isLoginPressed = false;

  @override
  Widget build(BuildContext context) {
    Future<void> _signOut(BuildContext context) async {
      try {
        GoogleSignIn _googleSignIn = GoogleSignIn();
        final auth = Provider.of<FirebaseAuthServices>(context, listen: false);

        if (_googleSignIn != null) {
          print("Google is called");
          await auth.signOutWhenGoogle();
        } else {
          print("Auth is Called");
          await auth.signOut();
        }
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)), color: Colors.indigo),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: CircleAvatar(
                        radius: 100,
                        child: Image.asset(
                          Constants.profile_icon_placeholder,
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Jwngma Basumatary",
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProfilePage();
                  }));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.account_box),
                          SizedBox(
                            width: 20,
                          ),
                          Text("My Profile"),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(Icons.arrow_right)),
                  ],
                ),
              ),
            ),
//            Divider(
//              height: 10,
//              color: Colors.red,
//            ),
//            SizedBox(
//              height: 10,
//            ),
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: InkWell(
//                onTap: () {
//                  Navigator.push(context, MaterialPageRoute(builder: (context) {
//                    return MyParticipationsEventCards();
//                  }));
//                },
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Container(
//                      child: Row(
//                        children: <Widget>[
//                          Icon(FontAwesomeIcons.affiliatetheme),
//                          SizedBox(
//                            width: 20,
//                          ),
//                          Text("App Theme"),
//                        ],
//                      ),
//                    ),
//                    Padding(
//                        padding: EdgeInsets.symmetric(horizontal: 20),
//                        child: Switch(value: true, onChanged: (bool value){
//
//                        })),
//                  ],
//                ),
//              ),
//            ),
            Divider(
              height: 1,
              color: Colors.red,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MyParticipationsPage();
                  }));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.games),
                          SizedBox(
                            width: 20,
                          ),
                          Text("My Participations"),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(Icons.arrow_right)),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
              color: Colors.red,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return WalletScreen();
                  }));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.account_box),
                          SizedBox(
                            width: 20,
                          ),
                          Text("My Wallet"),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(Icons.arrow_right)),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
              color: Colors.red,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HelpPage();
                  }));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.help),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Help/Support"),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(Icons.arrow_right)),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
              color: Colors.red,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PolicyPage();
                  }));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.security),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Policies"),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(Icons.arrow_right)),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
              color: Colors.red,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Share.share(Constants.share_link);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.share),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Share App"),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(Icons.arrow_right)),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
              color: Colors.red,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  _signOut(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.signOutAlt),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Log Out"),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(Icons.arrow_right)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
