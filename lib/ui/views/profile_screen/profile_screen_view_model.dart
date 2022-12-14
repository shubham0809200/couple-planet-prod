import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple_planet/app/services/firebase_auth_services.dart';
import 'package:couple_planet/app/services/firebase_storage_service.dart';
import 'package:couple_planet/app/services/firebase_user_service.dart';
import 'package:couple_planet/models/user.model.dart';
import 'package:couple_planet/ui/widgets/custom_snackbar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

class ProfileScreenViewModel extends FutureViewModel {
  String title = "Profile Screen".toUpperCase();
  String subTitle = "Your Search Ends here".toUpperCase();

  File? imageFile;

  BuildContext? context;
  UserModel? user;

  String imageUrl = "";
  bool isLoading = false;

  // controllers
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? aboutController;
  TextEditingController? phoneNumberController;
  TextEditingController? profileImageController;
  TextEditingController? genderController;
  TextEditingController? positionController;
  TextEditingController? ageController;
  List<dynamic> interestsController = [];
  List<dynamic> likedByUsersController = [];
  List<dynamic> sexualOrientation = [];
  List<dynamic> imageGalleryController = [];
  List<dynamic> intrestedInController = [];
  List<dynamic> matchedUsersController = [];

  Future<DocumentSnapshot> getUser() async {
    return FirebaseUserService().getUser();
  }

  Future signOutUser() async {
    await FirebaseAuthService().signOut();
  }

  Future<void> deleteAccount() {
    return FirebaseUserService().deleteAccount();
  }

  Future pickImage(ImageSource imageSource) async {
    imageFile = await FirebaseStorageService().pickImage(source: imageSource);
    notifyListeners();
  }

  void updateIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<String> updateProfile(BuildContext context) async {
    if (nameController?.text == '' ||
        emailController?.text == '' ||
        phoneNumberController?.text == '') {
      print("Please fill all the fields");
      customSnackbar(context, "Please Fill All the Fields", Colors.red);
      return "EMPTY";
    } else {
      String result = '';
      if (imageFile == null) {
        result = await addUserData(UserModel(
          id: FirebaseAuthService().user.uid,
          name: nameController!.text,
          email: emailController!.text,
          phoneNumber: phoneNumberController!.text,
          about: aboutController!.text,
          profileImage: profileImageController!.text,
          gender: genderController!.text,
          position: const GeoPoint(0, 0),
          age: Timestamp.now(),
          interests: interestsController,
          likedByUsers: likedByUsersController,
          sexualOrientation: sexualOrientation,
          imageGallery: imageGalleryController,
          intrestedIn: intrestedInController,
          matchedUsers: matchedUsersController,
        ));
      } else {
        await _uploadFile(imageFile!.path).then((value) async {
          result = await addUserData(UserModel(
            id: FirebaseAuthService().user.uid,
            name: nameController!.text,
            email: emailController!.text,
            phoneNumber: phoneNumberController!.text,
            about: aboutController!.text,
            profileImage: imageUrl,
            gender: genderController!.text,
            position: const GeoPoint(0, 0),
            age: Timestamp.now(),
            // age: ageController!.text == ''
            //     ? Timestamp.now()
            //     : Timestamp.fromDate(
            //         DateFormat('dd/MM/yyyy').parse(ageController!.text)),
            interests: interestsController,
            likedByUsers: likedByUsersController,
            sexualOrientation: sexualOrientation,
            imageGallery: imageGalleryController,
            intrestedIn: intrestedInController,
            matchedUsers: matchedUsersController,
          ));
        });
      }
      return result;
    }
  }

  Future addUserData(UserModel userModel) {
    return FirebaseUserService().addUserData(userModel.toJson());
  }

  Future _uploadFile(String path) async {
    imageUrl = await FirebaseStorageService().uploadUserImage(imageFile!.path);
    notifyListeners();
  }

  @override
  Future futureToRun() => getUser();
}
