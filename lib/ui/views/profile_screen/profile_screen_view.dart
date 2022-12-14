import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple_planet/core/constants.dart';
import 'package:couple_planet/core/route_constants.dart';
import 'package:couple_planet/models/user.model.dart';
import 'package:couple_planet/res/custom_constant_data.dart';
import 'package:couple_planet/ui/views/profile_screen/profile_screen_view_model.dart';
import 'package:couple_planet/ui/widgets/custom_snackbar.dart';
import 'package:couple_planet/ui/widgets/drop_down_answer.dart';
import 'package:couple_planet/ui/widgets/raised_gradient_button.dart';
import 'package:couple_planet/ui/widgets/round_image.dart';
import 'package:couple_planet/ui/widgets/single_answer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

part 'profile_screen_mobile.dart';

class ProfileScreenView extends StatelessWidget {
  const ProfileScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileScreenViewModel>.nonReactive(
        viewModelBuilder: () => ProfileScreenViewModel(),
        onModelReady: (model) {
          // Do Something on Model Ready
        },
        builder: (context, model, child) {
          return ScreenTypeLayout(
              mobile: _ProfileScreenMobile(
            viewModel: model,
          ));
        });
  }
}
