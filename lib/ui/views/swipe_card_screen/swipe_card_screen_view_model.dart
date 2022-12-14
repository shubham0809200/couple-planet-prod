import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple_planet/app/services/firebase_user_service.dart';
import 'package:stacked/stacked.dart';

class SwipeCardScreenViewModel extends FutureViewModel {
  String title = "Card Swipe".toUpperCase();

  Future<DocumentSnapshot> getUser() async {
    return FirebaseUserService().getUser();
  }

  @override
  Future futureToRun() => getUser();
}
