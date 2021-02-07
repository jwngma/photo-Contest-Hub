import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';
import 'package:flutter/services.dart';
import 'package:photocontesthub/inapp_purchase/CoinStorePage.dart';
import 'package:photocontesthub/screens/about_us.dart';

import 'package:photocontesthub/screens/help_page.dart';
import 'package:photocontesthub/screens/notification_page.dart';
import 'package:photocontesthub/screens/policy_page.dart';
import 'package:photocontesthub/screens/profile_page.dart';
import 'package:photocontesthub/screens/wallet_page.dart';
import 'package:photocontesthub/services/firebase_auth_services.dart';
import 'package:photocontesthub/utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import 'events/dashboard/home_screen.dart';
import 'events/upcoming/events_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "HomePage";
  final titles = [
    'Home',
    'Events',
    "Coin Store"
    'Results',
  ]; //'Events',
  final colors = [
    Colors.red,
    Colors.purple,
    Colors.green,
    Colors.cyan,
  ];
  final icons = [
    FontAwesomeIcons.home,
    FontAwesomeIcons.projectDiagram,
    FontAwesomeIcons.coins,
    FontAwesomeIcons.rProject,
  ];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey _bottomNavigationKey = GlobalKey();
  PageController _pageController;
  MenuPositionController _menuPositionController;
  bool userPageDragging = false;

  @override
  void initState() {
    _menuPositionController = MenuPositionController(initPosition: 0);

    _pageController =
        PageController(initialPage: 0, keepPage: false, viewportFraction: 1.0);
    _pageController.addListener(handlePageChange);

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void handlePageChange() {
    _menuPositionController.absolutePosition = _pageController.page;
  }

  void checkUserDragging(ScrollNotification scrollNotification) {
    if (scrollNotification is UserScrollNotification &&
        scrollNotification.direction != ScrollDirection.idle) {
      userPageDragging = true;
    } else if (scrollNotification is ScrollEndNotification) {
      userPageDragging = false;
    }
    if (userPageDragging) {
      _menuPositionController.findNearestTarget(_pageController.page);
    }
  }

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
  String app_bar_title = "Photo Contest Hub";
  final List<Widget> _screens = [
    new HomeScreen(),
    new EventsPage(),
   // new AllEventsPage(),
    new CoinStorePage(),
  ];



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Confirm Exit"),
                content: Text("Are you sure you want to exit?"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("YES"),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                  FlatButton(
                    child: Text("NO"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(app_bar_title),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.yellowAccent,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return NotificationPage();
                  }));
                }),
            SizedBox(
              width: 10,
            )
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: BubbledNavigationBar(
              controller: _menuPositionController,
              initialIndex: 1,
              itemMargin: EdgeInsets.symmetric(horizontal: 8),
              defaultBubbleColor: Colors.red,
              backgroundColor: Colors.grey[800],
              onTap: (index) {
                print(index.toString());
                _pageController.animateToPage(index,
                    curve: Curves.easeInOutQuad,
                    duration: Duration(milliseconds: 200));
              },
              items: widget.titles.map((title) {
                var index = widget.titles.indexOf(title);
                var color = widget.colors[index];
                return BubbledNavigationBarItem(
                  icon: getIcon(index, color),
                  activeIcon: getIcon(index, Colors.white),
                  bubbleColor: color,
                  title: Text(
                    title,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            checkUserDragging(scrollNotification);
          },
          child: PageView(
            controller: _pageController,
            children: _screens,
            onPageChanged: (page) {
              print(page);
              setState(() {
                switch (page) {
                  case 0:
                    app_bar_title = "Photo Contest Hub";
                    break;
                  case 1:
                    app_bar_title = "Events";
                    break;
                  case 2:
                    app_bar_title = "Results";
                    break;
                  default:
                    app_bar_title = "Coin Store";
                    break;
                }
              });
            },
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                  Constants.app_name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                accountEmail: Text(
                  "Participate more Earn more",
                  style: TextStyle(fontSize: 15, color: Colors.red),
                ),
                currentAccountPicture: new CircleAvatar(
                  child: Icon(Icons.account_box),
                  backgroundColor: Colors.red,
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1521856729154-7118f7181af9?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=375&q=80'),
                  fit: BoxFit.cover,
                )),
              ),
              ListTile(
                title: Text("Home"),
                leading: Icon(Icons.home),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }));
                },
              ),
//              Divider(
//                height: 1,
//                color: Colors.indigo,
//              ),
//              ListTile(
//                title: Text("My participations"),
//                leading: Icon(Icons.event),
//                onTap: () {
//                  Navigator.of(context).pop();
//                  Navigator.push(context, MaterialPageRoute(builder: (context) {
//                    return MyParticipationsPage();
//                  }));
//                },
//              ),
              Divider(
                height: 1,
                color: Colors.indigo,
              ),
              ListTile(
                title: Text("Profile"),
                leading: Icon(Icons.account_circle),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProfilePage();
                  }));
                },
              ),
              Divider(
                height: 1,
                color: Colors.indigo,
              ),
              ListTile(
                title: Text("Wallet"),
                leading: Icon(Icons.account_balance_wallet),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return WalletScreen();
                  }));
                },
              ),
              Divider(
                height: 1,
                color: Colors.indigo,
              ),

              ListTile(
                title: Text("Policies"),
                leading: Icon(Icons.security),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PolicyPage();
                  }));
                },
              ),
              Divider(
                height: 1,
                color: Colors.indigo,
              ),
              Divider(
                height: 1,
                color: Colors.indigo,
              ),

              ListTile(
                title: Text("Share App"),
                leading: Icon(Icons.share),
                onTap: () {
                  Navigator.of(context).pop();
                  Share.share(Constants.share_link);
                },
              ),
              Divider(
                height: 1,
                color: Colors.indigo,
              ),
              ListTile(
                title: Text("Help"),
                leading: Icon(Icons.help),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HelpPage();
                  }));
                },
              ),
              Divider(
                height: 1,
                color: Colors.indigo,
              ),

              ListTile(
                title: Text("About us"),
                leading: Icon(Icons.info),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AboutUsScreen();
                  }));
                },
              ),
              Divider(
                height: 1,
                color: Colors.indigo,
              ),
              ListTile(
                title: Text("Logout"),
                leading: Icon(FontAwesomeIcons.signOutAlt),
                onTap: () {
                  Navigator.of(context).pop();
                  _signOut(context);
                },
              ),
              Divider(
                height: 1,
                color: Colors.indigo,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding getIcon(int index, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Icon(widget.icons[index], size: 30, color: color),
    );
  }
}
