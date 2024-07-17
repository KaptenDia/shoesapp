// @dart=2.9
class UserModel {
  int id;
  String name;
  String email;
  String username;
  String address;
  String phone;
  String profilePhotoUrl;
  String token;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.username,
    this.address,
    this.phone,
    this.profilePhotoUrl,
    this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    profilePhotoUrl = json['profile_photo_url'];
    address = json['address'];
    phone = json['phone'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'photo_profile_url': profilePhotoUrl,
      'address': address,
      'phone': phone,
      'token': token,
    };
  }
}
