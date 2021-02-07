import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:photocontesthub/screens/wallet_page.dart';

class PaymentDialog extends StatelessWidget {
  final String title, description, primaryButtonText, primaryButtonRoute;

  static const double padding = 20.0;
  final primaryColor = const Color(0xFF75A2EA);
  final grayColor = const Color(0xFF939393);

  const PaymentDialog({
    @required this.title,
    @required this.description,
    @required this.primaryButtonText,
    @required this.primaryButtonRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(padding)),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      blurRadius: 10,
                      offset: const Offset(0.0, 10))
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 24,
                  ),
                  AutoSizeText(
                    title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: primaryColor, fontSize: 25),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  AutoSizeText(
                    description,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: grayColor, fontSize: 25),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  AutoSizeText(
                    description,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: grayColor, fontSize: 25),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  RaisedButton(
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: AutoSizeText(
                        primaryButtonText,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w200),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return WalletScreen();
                        }));
                      }),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
