import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatefulWidget {
  static const String routeName = "HelpPage";
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  TextEditingController _subController = TextEditingController();

  TextEditingController _messageController = TextEditingController();

  showToastt(String message) {
    showToast(message,
        context: context,
        backgroundColor: Colors.green,
        duration: Duration(seconds: 5),
        position: StyledToastPosition(align: Alignment.center, offset: 20.0));
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help "),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _subController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Enter The Subject"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _messageController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Enter Your Message"),
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
                    onPressed: () async {
                      if (_subController.text.toString() != null &&
                          _subController.text.toString() != "") {
                        var emailUrl =
                        '''mailto:talentcontesthub2020@gmail.com?subject=${_subController.text.toString()}&body=${_messageController.text.toString()}''';
                        var out = Uri.encodeFull(emailUrl);
                        await _launchURL(out);
                      } else {
                        showToastt("Fill the Both Fields");
                      }
                    },
                    child: Text(
                      "Send Message",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
