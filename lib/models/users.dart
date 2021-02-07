class Users {
  String uid;
  String name;
  int amount;
  String email;
  String username;
  String status;
  String facebook_name;
  String phone_number;
  String profile_photo;

  Users({this.uid,
    this.name,
    this.facebook_name,
    this.email,
    this.username,
    this.status,
    this.amount,
    this.phone_number,
    this.profile_photo});

  Map toMap(Users users) {
    var data = Map<String, dynamic>();
    data['uid'] = users.uid;
    data['name'] = users.name;
    data['phone_number'] = users.phone_number;
    data['facebook_name'] = users.facebook_name;
    data['email'] = users.email;
    data['username'] = users.username;
    data['status'] = users.status;
    data['amount'] = users.amount;
    data['profile_photo'] = users.profile_photo;

    return data;
  }

  Users.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.name = mapData['name'];
    this.facebook_name = mapData['facebook_name'];
    this.email = mapData['email'];
    this.username = mapData['username'];
    this.phone_number = mapData['phone_number'];
    this.status = mapData['status'];
    this.amount = mapData['amount'];
    this.profile_photo = mapData['profile_photo'];
  }
}
