import 'package:couple_planet/core/constants.dart';
import 'package:couple_planet/core/route_constants.dart';
import 'package:couple_planet/ui/views/sign_in_screen/sign_in_screen_view_model.dart';
import 'package:couple_planet/ui/widgets/raised_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';


import '../../../res/custom_color.dart';

part 'sign_in_screen_mobile.dart';

class SignInScreenView extends StatelessWidget {
  const SignInScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInScreenViewModel>.reactive(
        viewModelBuilder: () => SignInScreenViewModel(),
        onModelReady: (model) {
          // Do Something on Model Ready
        },
        builder: (context, model, child) {
          return ScreenTypeLayout(
              mobile: _SignInScreenMobile(
            viewModel: model,
          ));
        });
  }
}
