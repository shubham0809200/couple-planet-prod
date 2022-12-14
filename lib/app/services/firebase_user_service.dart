import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple_planet/app/services/firebase_auth_services.dart';

class FirebaseUserService {
  final CollectionReference reference =
      FirebaseFirestore.instance.collection('user');

  Future addUserData(Map<String, dynamic>? data) async {
    try {
      await reference
          .doc(FirebaseAuthService().user.uid)
          .set(data, SetOptions(merge: true));
      return 'SUCCESS';
    } on FirebaseException catch (e) {
      return e.message.toString();
    }
  }

  Future<DocumentSnapshot> getUser() async {
    try {
      return await reference.doc(FirebaseAuthService().user.uid).get();
    } on FirebaseException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteAccount() {
    return reference.doc(FirebaseAuthService().user.uid).delete();
  }
}
