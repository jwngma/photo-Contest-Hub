import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photocontesthub/services/facebook_services.dart';
import 'package:provider/provider.dart';
import 'package:photocontesthub/services/firebase_auth_services.dart';
import 'package:photocontesthub/services/firestore_services.dart';

class AuthWidgetBuilder extends StatelessWidget {
  final Widget Function(BuildContext, AsyncSnapshot<User>) builder;

  const AuthWidgetBuilder({Key key, this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Auth Widget Builder");
    final authServices =
        Provider.of<FirebaseAuthServices>(context, listen: false);
    return StreamBuilder<User>(
        stream: authServices.onAuthStateChanged,
        builder: (context, snapshot) {
          final user = snapshot.data;
          if (user != null) {
            return MultiProvider(
              providers: [
                Provider<User>.value(
                  value: user,
                ),
                Provider<FirestoreServices>(
                  create: (_) => FirestoreServices(),
                ),
                Provider<FacebookServices>(
                  create: (_) => FacebookServices(),
                ),
              ],
              child: builder(context, snapshot),
            );
          }
          return builder(context, snapshot);
        });
  }
}
