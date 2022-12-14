import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple_planet/core/constants.dart';
import 'package:couple_planet/ui/views/chat_screen/chat_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

part 'chat_screen_mobile.dart';

class ChatScreenView extends StatelessWidget {
  const ChatScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatScreenViewModel>.reactive(
        viewModelBuilder: () => ChatScreenViewModel(),
        onModelReady: (model) {
          // Do Something on Model Ready
        },
        builder: (context, model, child) {
          return ScreenTypeLayout(
              mobile: _ChatScreenMobile(
            viewModel: model,
          ));
        });
  }
}
