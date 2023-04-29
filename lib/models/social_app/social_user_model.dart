class SocialUserModel {
  String? name;
  String? email;
  String? phone;
  String? password;
  String? image;
  String? cover;
  String? uId;
  // bool? isEmailVerified;
  String? bio;

  SocialUserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.cover,
    this.password,
    required this.uId,
    required this.bio,
    //  required this.isEmailVerified,
  });
  SocialUserModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    //  isEmailVerified = json['isEmailVerified'];
    uId = json['uId'];
    cover = json['cover'];
    image = json['image'];
    bio = json['bio'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'uId': uId,
      'cover': cover,
      'image': image,
      'bio': bio,
    };
  }
}
