import 'package:flutter/material.dart';

customSnackbar(BuildContext context, String message, Color color) {
//  create a beautiful snackbar round corner and in center with space from bottom and left and right
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(
        bottom: 10,
        left: 10,
        right: 10,
      ),
    ),
  );
}
