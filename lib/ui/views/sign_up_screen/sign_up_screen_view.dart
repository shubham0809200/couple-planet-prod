import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple_planet/core/constants.dart';
import 'package:couple_planet/res/custom_constant_data.dart';
import 'package:couple_planet/ui/views/sign_up_screen/sign_up_screen_view_model.dart';
import 'package:couple_planet/ui/widgets/custom_snackbar.dart';
import 'package:couple_planet/ui/widgets/drop_down_answer.dart';
import 'package:couple_planet/ui/widgets/round_image.dart';
import 'package:couple_planet/ui/widgets/single_answer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import '../../../core/route_constants.dart';
import '../../../res/custom_color.dart';
import '../../widgets/raised_gradient_button.dart';

part 'sign_up_screen_mobile.dart';

class SignUpScreenView extends StatelessWidget {
  const SignUpScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpScreenViewModel>.reactive(
        viewModelBuilder: () => SignUpScreenViewModel(),
        onModelReady: (model) {
          // Do Something on Model Ready
          model.context = context;
        },
        builder: (context, model, child) {
          return ScreenTypeLayout(
              mobile: _SignUpScreenMobile(
            viewModel: model,
          ));
        });
  }
}
