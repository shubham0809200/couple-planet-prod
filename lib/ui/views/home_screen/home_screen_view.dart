import 'package:couple_planet/core/constants.dart';
import 'package:couple_planet/res/custom_color.dart';
import 'package:couple_planet/ui/views/home_screen/home_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

part 'home_screen_mobile.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeScreenViewModel>.reactive(
        viewModelBuilder: () => HomeScreenViewModel(),
        onModelReady: (model) {
          // Do Something on Model Ready
        },
        builder: (context, model, child) {
          return ScreenTypeLayout(
              mobile: _HomeScreenMobile(
            viewModel: model,
          ));
        });
  }
}
