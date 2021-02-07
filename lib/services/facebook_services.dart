import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:photocontesthub/models/FeedModel.dart';
import 'package:photocontesthub/models/eventPostModel.dart';
import 'package:photocontesthub/models/postResponse.dart';
import 'dart:convert' as convert;
import 'dart:async';

class FacebookServices {
  //https://graph.facebook.com/107795670802125/feed?fields=likes,comments,reactions,shares,message&access_token=EAACTygdMyqUBALkVBEcnsMa9XIoF6DHHYLQ7YkQm5Pp94LDfqR7jU5AK07jYROoPBMM6hunUkkjjH392cZC6KhqEROZA8Kmi8vkZAy4aXR9gAlTNjA9u326OaKZCVmZChn8uo43gcLzCWH7ldhoVEGD0e6fiZAldUOfiyZA8iWVLAZDZD
  Future<PostResponse> createPost(
      EventPostModel eventPostModel, String url) async {
    String api_url = "https://graph.facebook.com/107795670802125/photos";
    String status = eventPostModel.eventTag +
        "1" +
        "\n" +
        eventPostModel.eventPromotionStatus +
        "\n" +
        "Registration Fee: Rs: ${eventPostModel.registrationFee}" +
        "\n#Contestant_Name: ${eventPostModel.contestantName}" +
        "\n\n${eventPostModel.rulesTag}" +
        "\n1. Install Our App ${"'Photo Contest Hub'"} from Playstore \n#Link_to_App- https://play.google.com/store/apps/details?id=com.gamepayindia \n2. Register an Account "
            "\n3. Participate in Event and Upload your best Picture from the App \n4. Winners will be Decided on the basis of maximum likes, share and Comments of the photo uploaded from our app \n"
            "1 share= ${eventPostModel.sharePoint} \n1 Comment= ${eventPostModel.commentPoint} \n1 Like= ${eventPostModel.likePoint}\n1 Wow= ${eventPostModel.wowPoint}" +
        "\nVoting Start date: ${eventPostModel.startDate}" +
        "\nVoting End date: ${eventPostModel.endDate}" +
        "\nPage Name: ${eventPostModel.pageName}";
    var bodyMap = Map<String, dynamic>();
    bodyMap['message'] = status;
    bodyMap['url'] = url;
    //bodyMap['scheduled_publish_time']="";
    bodyMap['access_token'] =
        "EAACTygdMyqUBALkVBEcnsMa9XIoF6DHHYLQ7YkQm5Pp94LDfqR7jU5AK07jYROoPBMM6hunUkkjjH392cZC6KhqEROZA8Kmi8vkZAy4aXR9gAlTNjA9u326OaKZCVmZChn8uo43gcLzCWH7ldhoVEGD0e6fiZAldUOfiyZA8iWVLAZDZD";
    var response = await http.post(
      api_url,
      body: bodyMap,
    );
    var jsonResponse = json.decode(response.body);
    return PostResponse.fromJson(jsonResponse);
  }

  Future<List<Data>> getFeed() async {
    var feedList = List<Data>();
    String api_url =
        "https://graph.facebook.com/100505921685244/feed?fields=full_picture,likes,comments,shares,reactions,message&access_token=EAAO0miU8D2QBAIbOVmixKFtEavlSn2sua6RkrQGgA40ZC8Ev5J88vJk8vu9n5I8AmeqrafkzFRx0goeVKDyXvZAK3aG2OCDYvYvpsgZAZB89MT5pyc6ihFI6wlXE4wnTSRrjYtsjZAIccgJu5uWnxBppk9sLr6pcZClYHoZCSmOkYUSsUMY426auUg29cMlVQ42T3ZANby3yVCunhm7Kmiz3K01cMNrV30EeZBvCXLTuZCjwZDZD";
    var response = await http.get(api_url);
    var jsonResponse = json.decode(response.body);
    var data=jsonResponse['data'];
    data.forEach((feed) => feedList.add(Data.fromJson(feed)));
    print("Length of Items: ${feedList.length}");
    return feedList;
  }
}
