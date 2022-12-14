import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String id;
  late String name;
  late String email;
  late String about;
  late String phoneNumber;
  late String profileImage;
  late String gender;
  late GeoPoint position;
  late Timestamp age;
  late List<dynamic> interests;
  late List<dynamic> likedByUsers;
  late List<dynamic> sexualOrientation;
  late List<dynamic> imageGallery;
  late List<dynamic> intrestedIn;
  late List<dynamic> matchedUsers;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.about,
    required this.phoneNumber,
    required this.profileImage,
    required this.gender,
    required this.position,
    required this.age,
    required this.interests,
    required this.likedByUsers,
    required this.sexualOrientation,
    required this.imageGallery,
    required this.intrestedIn,
    required this.matchedUsers,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    about = json['about'];
    phoneNumber = json['phoneNumber'];
    profileImage = json['profileImage'];
    gender = json['gender'];
    position = json['position'];
    age = json['age'];
    interests = json['interests'];
    likedByUsers = json['likedByUsers'];
    sexualOrientation = json['sexualOrientation'];
    imageGallery = json['imageGallery'];
    intrestedIn = json['intrestedIn'];
    matchedUsers = json['matchedUsers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['about'] = about;
    data['phoneNumber'] = phoneNumber;
    data['profileImage'] = profileImage;
    data['gender'] = gender;
    data['position'] = position;
    data['age'] = age;
    data['interests'] = interests;
    data['likedByUsers'] = likedByUsers;
    data['sexualOrientation'] = sexualOrientation;
    data['imageGallery'] = imageGallery;
    data['intrestedIn'] = intrestedIn;
    data['matchedUsers'] = matchedUsers;
    return data;
  }
}
