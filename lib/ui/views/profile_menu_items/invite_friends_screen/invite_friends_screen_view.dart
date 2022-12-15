import 'package:couple_planet/ui/views/profile_menu_items/invite_friends_screen/invite_friends_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

part 'invite_friends_screen_mobile.dart';

class InviteFriendsScreenView extends StatelessWidget {
  const InviteFriendsScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InviteFriendsScreenViewModel>.reactive(
        viewModelBuilder: () => InviteFriendsScreenViewModel(),
        onModelReady: (model) {
          // Do Something on Model Ready
        },
        builder: (context, model, child) {
          return ScreenTypeLayout(
              mobile: _InviteFriendsScreenMobile(
            viewModel: model,
          ));
        });
  }
}
