import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photocontesthub/models/FeedModel.dart';
import 'package:photocontesthub/utils/Constants.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:date_format/date_format.dart';

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
      child: data.fullPicture != null
          ? Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(data.fullPicture == null
                                  ? "https://images.unsplash.com/photo-1549845375-ce0a0ba8288c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"
                                  : data.fullPicture),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Photo Contest Hub",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 3),
                          Text(
                            '${formatDate(DateTime.parse(data.createdTime), [
                              yyyy,
                              '/',
                              mm,
                              '/',
                              dd,
                              ' ',
                              hh,
                              ':',
                              nn,
                              ':',
                              ss,
                              ' ',
                              am
                            ])}',
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      )
                    ]),
                    IconButton(
                        icon: Icon(
                          Icons.more_horiz,
                          color: Colors.grey,
                          size: 30,
                        ),
                        onPressed: () {})
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return FullImageScreen(
                          fullImageLink: data.fullPicture == null
                              ? "https://images.unsplash.com/photo-1549845375-ce0a0ba8288c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"
                              : data.fullPicture,
                          tag: "imageHero",
                        );
                      }));
                    },
                    child: Container(
                      child: CachedNetworkImage(
                        imageUrl: data.fullPicture == null
                            ? "https://images.unsplash.com/photo-1549845375-ce0a0ba8288c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"
                            : data.fullPicture,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        placeholder: (context, url) =>
                            Image.asset(Constants.gallery_placeholder),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                ),

                //To be D3leted
//                SizedBox(
//                  child: Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                      children: <Widget>[
//                        Container(
//                          decoration: BoxDecoration(
//                              borderRadius: BorderRadius.circular(5)),
//                          padding: EdgeInsets.symmetric(horizontal: 10),
//                          child: RaisedButton(
//                            color: Colors.blueAccent,
//                            onPressed: () async {
//                              Share.share(
//                                  "https://m.facebook.com/story.php?story_fbid=${data.id.substring("${data.id.substring(0, data.id.indexOf("_"))}".length + 1, data.id.length)}&substory_index=0&id=${data.id.substring(0, data.id.indexOf("_"))}");
//                            },
//                            child: Column(children: [
//                              new Center(
//                                  child: Text("Share",
//                                      style: TextStyle(color: Colors.white))),
//                              Text(
//                                "with Facebook/whatsapp/message",
//                                textAlign: TextAlign.center,
//                                style:
//                                    TextStyle(fontSize: 6, color: Colors.white),
//                              )
//                            ]),
//                          ),
//                        ),
//                        Container(
//                          decoration: BoxDecoration(
//                              borderRadius: BorderRadius.circular(5)),
//                          padding: EdgeInsets.symmetric(horizontal: 10),
//                          child: RaisedButton(
//                            color: Colors.blueAccent,
//                            onPressed: () async {
//                              await _launchURL(
//                                  "https://m.facebook.com/story.php?story_fbid=${data.id.substring("${data.id.substring(0, data.id.indexOf("_"))}".length + 1, data.id.length)}&substory_index=0&id=${data.id.substring(0, data.id.indexOf("_"))}");
//                            },
//                            child: Column(children: [
//                              Center(
//                                  child: Text(
//                                "Facebook",
//                                style: TextStyle(color: Colors.white),
//                                textAlign: TextAlign.center,
//                              )),
//                              Text(
//                                "Open In Facebook/browsers",
//                                style:
//                                    TextStyle(fontSize: 5, color: Colors.white),
//                              )
//                            ]),
//                          ),
//                        )
//                      ],
//                    ),
//                  ),
//                ),
//                Padding(
//                  padding: const EdgeInsets.symmetric(horizontal: 10),
//                  child: Container(
//                    color: Colors.grey[200],
//                    child: DescriptionTextWidget(
//                      text: data.message,
//                    ),
//                  ),
//                ),

                ////////////////////////////////.......................................////////////////////////////////

                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          makeLike(),
                          Transform.translate(
                              offset: Offset(-5, 0), child: makeLove()),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "2.5K",
                            style:
                                TextStyle(fontSize: 15, color: Colors.grey[800]),
                          )
                        ],
                      ),
                      Text(
                        "400 Comments",
                        style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      makeLikeButton(isActive: false),
                      makeCommentButton(),
                      makeShareButton(),
                    ],
                  ),
                )
              ],
            )
          : Container(
              child: data.message == ''
                  ? Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(data.fullPicture ==
                                              null
                                          ? "https://images.unsplash.com/photo-1549845375-ce0a0ba8288c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"
                                          : data.fullPicture),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Message For All",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    '${data.createdTime}',
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              )
                            ]),
                            IconButton(
                                icon: Icon(
                                  Icons.more_horiz,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                                onPressed: () {})
                          ],
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            color: Colors.grey[200],
                            child: DescriptionTextWidget(
                              text: data.message,
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox()),
    );
  }

  Widget makeLike() {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white)),
      child: Center(
        child: Icon(Icons.thumb_up, size: 12, color: Colors.white),
      ),
    );
  }

  Widget makeLove() {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white)),
      child: Center(
        child: Icon(Icons.favorite, size: 12, color: Colors.white),
      ),
    );
  }

  Widget makeLikeButton({isActive}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.thumb_up,
              color: isActive ? Colors.blue : Colors.grey,
              size: 18,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Like",
              style: TextStyle(color: isActive ? Colors.blue : Colors.grey),
            )
          ],
        ),
      ),
    );
  }

  Widget makeCommentButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.chat, color: Colors.grey, size: 18),
            SizedBox(
              width: 5,
            ),
            Text(
              "Comment",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }

  Widget makeShareButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.share, color: Colors.grey, size: 18),
            SizedBox(
              width: 5,
            ),
            Text(
              "Share",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
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

    if (widget.text == null) {
      firstHalf = '';
      secondHalf = "";
    } else if (widget.text.length > 50) {
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
