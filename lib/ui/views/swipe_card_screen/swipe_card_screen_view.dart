import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple_planet/core/constants.dart';
import 'package:couple_planet/ui/views/swipe_card_screen/swipe_card_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

part 'swipe_card_screen_mobile.dart';

class SwipeCardScreenView extends StatelessWidget {
  const SwipeCardScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SwipeCardScreenViewModel>.reactive(
        viewModelBuilder: () => SwipeCardScreenViewModel(),
        onModelReady: (model) {
          // Do Something on Model Ready
        },
        builder: (context, model, child) {
          return ScreenTypeLayout(
              mobile: _SwipeCardScreenMobile(
            viewModel: model,
          ));
        });
  }
}
