class PostResponse {
  String id;
  String post_id;

  PostResponse({this.id, this.post_id});

  PostResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    post_id = json['post_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['post_id'] = this.post_id;
    return data;
  }
}

