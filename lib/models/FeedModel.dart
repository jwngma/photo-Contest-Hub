class FeedModel {
  List<Data> data;

  FeedModel({this.data});

  FeedModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String fullPicture;
  String message;
  String id;
  Likes likes;
  CommentData comments;
  Shares shares;
  ReactionData reactions;
  String createdTime;
  String updatedTime;

  Data(
      {this.fullPicture,
        this.message,
        this.id,
        this.likes,
        this.comments,
        this.shares,
        this.reactions,
        this.createdTime,
      this.updatedTime,
        });

  Data.fromJson(Map<String, dynamic> json) {
    fullPicture = json['full_picture'];
    message = json['message'];
    id = json['id'];
    createdTime = json['created_time'];
    updatedTime = json['updated_time'];
    likes =
    json['likes'] != null ? new Likes.fromJson(json['likes']) : null;
    comments = json['comments'] != null
        ? new CommentData.fromJson(json['comments'])
        : null;
    shares =
    json['shares'] != null ? new Shares.fromJson(json['shares']) : null;
    reactions = json['reactions'] != null
        ? new ReactionData.fromJson(json['reactions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_picture'] = this.fullPicture;
    data['message'] = this.message;
    data['id'] = this.id;
    data['created_time'] = this.createdTime;
    data['updated_time'] = this.updatedTime;
    if (this.likes != null) {
      data['likes'] = this.likes.toJson();
    }
    if (this.comments != null) {
      data['comments'] = this.comments.toJson();
    }
    if (this.shares != null) {
      data['shares'] = this.shares.toJson();
    }
    if (this.reactions != null) {
      data['reactions'] = this.reactions.toJson();
    }
    return data;
  }
}
class Likes {
  String id;
  String name;

  Likes({this.id, this.name});

  Likes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}


class CommentFromData {
  String id;
  String name;

  CommentFromData({this.id, this.name});

  CommentFromData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}




class CommentData {
  String createdTime;
  CommentFromData from;
  String message;
  String id;

  CommentData({this.createdTime, this.from, this.message, this.id});

  CommentData.fromJson(Map<String, dynamic> json) {
    createdTime = json['created_time'];
    from = json['from'] != null ? new CommentFromData.fromJson(json['from']) : null;
    message = json['message'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_time'] = this.createdTime;
    if (this.from != null) {
      data['from'] = this.from.toJson();
    }
    data['message'] = this.message;
    data['id'] = this.id;
    return data;
  }
}

class Shares {
  int count;

  Shares({this.count});

  Shares.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}

class ReactionData {
  String id;
  String name;
  String type;

  ReactionData({this.id, this.name, this.type});

  ReactionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}
