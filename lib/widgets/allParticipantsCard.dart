import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photocontesthub/models/AllParticiapantsModel.dart';
import 'package:photocontesthub/models/FeedModel.dart';
import 'package:photocontesthub/services/firestore_services.dart';
import 'package:photocontesthub/utils/Constants.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:date_format/date_format.dart';

class AllParticipantsCard extends StatefulWidget {
  AllParticipantsModel data;
  int index;
  String eventId;

  AllParticipantsCard(this.data, this.index, this.eventId);

  @override
  _AllParticipantsCardState createState() =>
      _AllParticipantsCardState(data, index, eventId);
}

class _AllParticipantsCardState extends State<AllParticipantsCard> {
  final AllParticipantsModel data;
  int index;
  String eventId;

  bool liked = false;
  int likedCount=0;


  _AllParticipantsCardState(this.data, this.index, this.eventId);

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    liked = data.liked;
    likedCount=data.likes;
    print("liked -${liked}");
    print("likedCount -${likedCount}");
    print("Image Link -${data.image}");
    print("Name -${data.name}");
    print("Uid -${data.uid}");
    print("Image Link -${data.image}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final firestore = Provider.of<FirestoreServices>(context, listen: false);
    return Container(
      child: Column(
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
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1549845375-ce0a0ba8288c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"))),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data.name}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Location of the User",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 3),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FullImageScreen(
                    fullImageLink: data.image == null
                        ? "https://images.unsplash.com/photo-1549845375-ce0a0ba8288c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"
                        : data.image,
                    tag: "imageHero",
                  );
                }));
              },
              child: Container(
                child: CachedNetworkImage(
                  imageUrl: widget.data.image == null
                      ? "https://images.unsplash.com/photo-1549845375-ce0a0ba8288c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"
                      : widget.data.image,
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

          // To be Deleted

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
                      width: 2,
                    ),
                    Text(
                      "${likedCount} Likes",
                      style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                    )
                  ],
                ),
                Text(
                  "${likedCount} Comments",
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
                //makeLikeButton(isActive: false),
                GestureDetector(
                  onTap: () {
                    if (liked) {

                      firestore
                          .unlikePost(context, eventId, data.uid)
                          .then((value) {
                        setState(() {
                          liked = false;
                          likedCount=likedCount-1;
                        });
                      });

                    } else {
                      firestore
                          .likePost(context, eventId, data.uid)
                          .then((value) {
                        setState(() {

                          liked = true;
                          likedCount=likedCount+1;

                        });
                      });
                    }

                    print("Like Cliked");
                  },
                  child: Container(
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
                            color: liked ? Colors.red : Colors.grey,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Like",
                            style: TextStyle(
                                color: true ? Colors.blue : Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                makeCommentButton(),
                makeShareButton(),
              ],
            ),
          )
        ],
      ),
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
          color: data.liked ? Colors.red : Colors.indigo,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white)),
      child: Center(
        child: Icon(Icons.favorite, size: 12, color: Colors.white),
      ),
    );
  }

  Widget makeLikeButton({isActive}) {
    return GestureDetector(
      onTap: () {
        print("Like Cliked");
      },
      child: Container(
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
                color: data.liked ? Colors.red : Colors.grey,
                size: 18,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Like",
                style: TextStyle(color: isActive ? Colors.blue : Colors.white),
              )
            ],
          ),
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
            Icon(Icons.chat, color: Colors.green, size: 18),
            SizedBox(
              width: 5,
            ),
            Text(
              "Comment",
              style: TextStyle(color: Colors.white),
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
            Icon(Icons.share, color: Colors.green, size: 18),
            SizedBox(
              width: 5,
            ),
            Text(
              "Share",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
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
