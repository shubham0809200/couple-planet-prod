import 'package:fast_contacts/fast_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

class InviteFriendsScreenViewModel extends FutureViewModel {
  Future<List<Contact>> getContacts() async {
    try {
      bool isGranted = await Permission.contacts.status.isGranted;

      if (!isGranted) {
        isGranted = await Permission.contacts.request().isGranted;
      }
      if (isGranted) {
        return await FastContacts.allContacts;
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future futureToRun() => getContacts();
}
