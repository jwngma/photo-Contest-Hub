import 'package:flutter/material.dart';
import 'package:photocontesthub/screens/profile_page.dart';
import 'package:photocontesthub/screens/wallet_page.dart';
import 'package:provider/provider.dart';
import 'package:photocontesthub/screens/account_page.dart';
import 'package:photocontesthub/screens/home_page.dart';
import 'package:photocontesthub/screens/signup_page.dart';
import 'package:photocontesthub/services/firebase_auth_services.dart';
import 'auth_widget.dart';
import 'auth_widget_builder.dart';

class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {


  @override
  Widget build(BuildContext context) {
    return Provider<FirebaseAuthServices>(
      create: (_) => FirebaseAuthServices(),
      child: AuthWidgetBuilder(builder: (context, userSnapshot) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                brightness: Brightness.dark,
                primarySwatch: Colors.indigo,
                primaryColor: Colors.indigo),
            routes: {
              "/home": (context) => HomePage(),
              HomePage.routeName: (context) => HomePage(),
              "/account": (context) => AccountScreen(),
              "/signUp": (context) => SignUpPage(
                    authFormType: AuthFormType.SignUp,
                  ),
              "/signIn": (context) => SignUpPage(
                    authFormType: AuthFormType.SignIn,
                  ),
              AccountScreen.routeName: (context) => AccountScreen(),
              WalletScreen.routeName: (context) => WalletScreen(),
              ProfilePage.routeName: (context) => ProfilePage(),
            },
            home:// SplashScreenPage(userSnapshot: userSnapshot));

        AuthWidget(userSnapshot: userSnapshot));
      }),
    );
  }
}
