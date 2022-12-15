import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple_planet/core/constants.dart';
import 'package:couple_planet/core/route_constants.dart';
import 'package:couple_planet/models/user.model.dart';
import 'package:couple_planet/ui/views/profile_menu_screen/profile_menu_screen_view_model.dart';
import 'package:couple_planet/ui/widgets/round_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

part 'profile_menu_screen_mobile.dart';

class ProfileMenuScreenView extends StatelessWidget {
  const ProfileMenuScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileMenuScreenViewModel>.reactive(
        viewModelBuilder: () => ProfileMenuScreenViewModel(),
        onModelReady: (model) {
          // Do Something on Model Ready
        },
        builder: (context, model, child) {
          return ScreenTypeLayout(
              mobile: _ProfileMenuScreenMobile(
            viewModel: model,
          ));
        });
  }
}
