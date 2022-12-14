import 'dart:io';
import 'dart:typed_data';

import 'package:couple_planet/res/custom_color.dart';
import 'package:flutter/material.dart';

class AppRoundImage extends StatelessWidget {
  final ImageProvider provider;
  final double height;
  final double width;
  final bool hasBorder;

  AppRoundImage(this.provider,
      {required this.height, required this.width, required this.hasBorder});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height + 16 / 2),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Palette.firebaseOrange,
              Palette.firebaseAmber,
              Palette.firebaseYellow
            ],
          ),
        ),
        child: Padding(
          padding:
              hasBorder ? const EdgeInsets.all(4.0) : const EdgeInsets.all(0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(height / 2),
            child: Image(
              image: provider,
              height: height,
              width: width,
            ),
          ),
        ),
      ),
    );
  }

  factory AppRoundImage.url(String url,
      {required double height,
      required double width,
      required bool hasBorder}) {
    return AppRoundImage(
      NetworkImage(url),
      height: height,
      width: width,
      hasBorder: hasBorder,
    );
  }

  factory AppRoundImage.memory(Uint8List data,
      {required double height,
      required double width,
      required bool hasBorder}) {
    return AppRoundImage(
      MemoryImage(data),
      height: height,
      width: width,
      hasBorder: hasBorder,
    );
  }

  factory AppRoundImage.assets(String path,
      {required double height,
      required double width,
      required bool hasBorder}) {
    return AppRoundImage(
      AssetImage(path),
      height: height,
      width: width,
      hasBorder: hasBorder,
    );
  }

  factory AppRoundImage.file(File file,
      {required double height,
      required double width,
      required bool hasBorder}) {
    return AppRoundImage(
      FileImage(file),
      height: height,
      width: width,
      hasBorder: hasBorder,
    );
  }
}
