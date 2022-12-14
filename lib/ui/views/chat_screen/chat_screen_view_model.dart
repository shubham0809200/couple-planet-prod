import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple_planet/app/services/firebase_user_service.dart';
import 'package:stacked/stacked.dart';

class ChatScreenViewModel extends FutureViewModel {
  String title = "Chat Screen".toUpperCase();

  Future<DocumentSnapshot> getUser() async {
    return FirebaseUserService().getUser();
  }

  @override
  Future futureToRun() => getUser();
}
