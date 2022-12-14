import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple_planet/app/services/firebase_auth_services.dart';
import 'package:couple_planet/app/services/firebase_storage_service.dart';
import 'package:couple_planet/app/services/firebase_user_service.dart';
import 'package:couple_planet/models/user.model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;

class SignUpScreenViewModel extends BaseViewModel {
  String title = "SignUp Screen".toUpperCase();
  String subTitle = "your search ends here".toUpperCase();

  SignUpScreenViewModel();

  BuildContext? context;

  String emailId = '';
  String password = '';
  String confirmPassword = '';
  String name = '';
  String phoneNumber = '';
  String age = '';
  String about = '';
  String gender = 'Man';

  String imageUrl = "";

  bool uploadingData = false;
  bool isLoading = false;
  int selectedInputField = 0;
  String? value;

  File? imageFile;

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  void onPasswordVisibilityChanged() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void onConfirmPasswordVisibilityChanged() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  Future<String> signInUser() async {
    print('SIGN IN USER');

    if (emailId == '' ||
        password == '' ||
        confirmPassword == '' ||
        name == '' ||
        phoneNumber == '') {
      print('SIGN IN Empty');
      return 'EMPTY';
    } else {
      if (password != confirmPassword) {
        return 'PASSWORD_DIDNT_MATCH';
      } else {
        print('Doing');
        String result = await FirebaseAuthService()
            .signUp(email: emailId, password: password);

        if (result == 'SUCCESS') {
          if (imageFile == null) {
            await addUserData(UserModel(
              id: FirebaseAuthService().user.uid,
              name: name,
              email: emailId,
              phoneNumber: phoneNumber,
              about: '',
              profileImage: '',
              gender: gender,
              position: const GeoPoint(0, 0),
              age: age == ''
                  ? Timestamp.now()
                  : Timestamp.fromDate(DateFormat('dd/MM/yyyy').parse(age)),
              interests: [],
              likedByUsers: [],
              sexualOrientation: [],
              imageGallery: [],
              intrestedIn: [],
              matchedUsers: [],
            ));
          } else {
            await _uploadFile(imageFile!.path).then((value) async {
              await addUserData(UserModel(
                id: FirebaseAuthService().user.uid,
                name: name,
                email: emailId,
                phoneNumber: phoneNumber,
                about: '',
                profileImage: imageUrl,
                gender: gender,
                position: const GeoPoint(0, 0),
                age: age == ''
                    ? Timestamp.now()
                    : Timestamp.fromDate(DateFormat('dd/MM/yyyy').parse(age)),
                interests: [],
                likedByUsers: [],
                sexualOrientation: [],
                imageGallery: [],
                intrestedIn: [],
                matchedUsers: [],
              ));
            });
          }
        }
        return result;
      }
    }
  }

  void updateIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future addUserData(UserModel user) {
    return FirebaseUserService().addUserData(user.toJson());
  }

  Future pickImage(ImageSource imageSource) async {
    imageFile = await FirebaseStorageService().pickImage(source: imageSource);
    notifyListeners();
  }

  Future _uploadFile(String path) async {
    imageUrl = await FirebaseStorageService().uploadUserImage(path);
    notifyListeners();
  }

  Future<String> datePicker(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 6570)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now().subtract(const Duration(days: 6570)),
    ).then((date) {
      if (date != null) {
        return DateFormat('dd-MM-yyyy').format(date).toString();
      } else {
        return "";
      }
    });
  }
}
