import 'package:couple_planet/ui/views/chat_screen/chat_screen_view.dart';
import 'package:couple_planet/ui/views/match_screen/match_screen_view.dart';
import 'package:couple_planet/ui/views/profile_screen/profile_screen_view.dart';
import 'package:couple_planet/ui/views/swipe_card_screen/swipe_card_screen_view.dart';
import 'package:stacked/stacked.dart';

class HomeScreenViewModel extends BaseViewModel {
  int pageIndex = 0;
  String title = 'Home';

  final pages = [
    const SwipeCardScreenView(),
    const MatchScreenView(),
    const ChatScreenView(),
    const ProfileScreenView()
  ];

  void updatePageIndex(int index) {
    pageIndex = index;
    if (index == 0) {
      title = 'Meet the one';
    } else if (index == 1) {
      title = 'Your Matches';
    } else if (index == 2) {
      title = 'Chat';
    } else if (index == 3) {
      title = 'User Profile';
    }
    notifyListeners();
  }
}
