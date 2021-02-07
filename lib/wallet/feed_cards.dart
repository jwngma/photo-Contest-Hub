import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photocontesthub/models/FeedModel.dart';
import 'package:photocontesthub/utils/Constants.dart';

import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeFeedCards extends StatelessWidget {
  Data data;

  HomeFeedCards(this.data);

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FullImageScreen(
                    fullImageLink: data.fullPicture==null?"https://images.unsplash.com/photo-1549845375-ce0a0ba8288c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60":data.fullPicture,
                    tag: "imageHero",
                  );
                }));
              },
              child: Container(
                child: CachedNetworkImage(
                  imageUrl: data.fullPicture==null?"https://images.unsplash.com/photo-1549845375-ce0a0ba8288c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60":data.fullPicture,
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  placeholder: (context, url) =>
                      Image.asset(Constants.gallery_placeholder),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  Flexible(
                    child: GestureDetector(
                      onTap: () {
                        Share.share(
                            "https://m.facebook.com/story.php?story_fbid=${data.id.substring("${data.id.substring(0, data.id.indexOf("_"))}".length + 1, data.id.length)}&substory_index=0&id=${data.id.substring(0, data.id.indexOf("_"))}");
                      },
                      child: Container(
                        decoration:
                            BoxDecoration(border: Border.all(color: Colors.blue)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 3, vertical: 3),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.share,
                                color: Colors.greenAccent,
                              ),
                              SizedBox(
                                width: 5
                              ),
                              Column(
                                children: <Widget>[
                                  Text("Share", style: TextStyle( color: Colors.black)),
                                  Text(
                                    "with Facebook/whatsapp/message",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 6,color: Colors.black),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: () async {
                        await _launchURL(
                            "https://m.facebook.com/story.php?story_fbid=${data.id.substring("${data.id.substring(0, data.id.indexOf("_"))}".length + 1, data.id.length)}&substory_index=0&id=${data.id.substring(0, data.id.indexOf("_"))}");
                      },
                      child: Container(
                        decoration:
                            BoxDecoration(border: Border.all(color: Colors.blue)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 3, vertical: 3),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.facebook,
                                  color: Colors.greenAccent,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Center(child: Text("Facebook", style: TextStyle( color: Colors.black),  textAlign: TextAlign.center,)),
                                    Text(
                                      "Open In Facebook/browsers",
                                      style: TextStyle(fontSize: 5, color: Colors.black),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
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

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({@required this.text});

  @override
  _DescriptionTextWidgetState createState() =>
      new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String firstHalf;
  String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 50) {
      firstHalf = widget.text.substring(186, 350);
      secondHalf = widget.text.substring(250, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? new Text(
              firstHalf,
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.black),
            )
          : new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Text(
                  flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                new InkWell(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            color: Colors.green[100]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 3),
                          child: new Text(
                            flag ? "show more" : "show less",
                            style: new TextStyle(
                                color: Colors.black, fontSize: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}

class FullImageScreen extends StatefulWidget {
  final String fullImageLink;
  final String tag;

  const FullImageScreen({Key key, this.fullImageLink, this.tag})
      : super(key: key);

  @override
  _FullImageScreenState createState() =>
      _FullImageScreenState(this.fullImageLink, this.tag);
}

class _FullImageScreenState extends State<FullImageScreen> {
  final String fullImageLink;
  final String tag;

  _FullImageScreenState(this.fullImageLink, this.tag);

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: "imageHero",
            child: CachedNetworkImage(
              imageUrl: widget.fullImageLink,
              placeholder: (context, url) => Center(
                  child: Container(
                      width: 32,
                      height: 32,
                      child: new CircularProgressIndicator())),
              //placeholder: Center(child: Container(width: 32, height: 32,child: new CircularProgressIndicator())),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
