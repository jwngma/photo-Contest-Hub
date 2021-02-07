class AllParticipantsModel {
  String facebook_name;
  String id;
  String name;
  String post_id;
  String uid;
  String winner;
  String winner_prize;
  String image;
  int likes;
  bool liked = false;

  AllParticipantsModel(
      {this.facebook_name,
      this.id,
      this.name,
      this.post_id,
      this.uid,
      this.winner,
      this.winner_prize,
      this.image,
      this.likes,
      this.liked});

  AllParticipantsModel.fromJson(Map<String, dynamic> json) {
    facebook_name = json['facebook_name'];
    id = json['id'];
    name = json['name'];
    post_id = json['post_id'];
    uid = json['uid'];
    winner = json['winner'];
    winner_prize = json['winner_prize'];
    image = json['image'];
    likes = json['likes'];
    liked = json['liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['facebook_name'] = this.facebook_name;
    data['id'] = this.id;
    data['name'] = this.name;
    data['post_id'] = this.post_id;
    data['uid'] = this.uid;
    data['winner'] = this.winner;
    data['winner_prize'] = this.winner_prize;
    data['image'] = this.image;
    data['likes'] = this.likes;
    data['liked'] = this.liked;

    return data;
  }
}
