import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple_planet/core/constants.dart';
import 'package:couple_planet/ui/views/match_screen/match_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

part 'match_screen_mobile.dart';

class MatchScreenView extends StatelessWidget {
  const MatchScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MatchScreenViewModel>.reactive(
        viewModelBuilder: () => MatchScreenViewModel(),
        onModelReady: (model) {
          // Do Something on Model Ready
        },
        builder: (context, model, child) {
          return ScreenTypeLayout(
              mobile: _MatchScreenMobile(
            viewModel: model,
          ));
        });
  }
}
