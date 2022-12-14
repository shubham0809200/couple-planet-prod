import 'package:flutter/material.dart';
import '../../res/custom_color.dart';

class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final bool isActive;
  final Function() onPressed;

  const RaisedGradientButton({
    Key? key,
    required this.child,
    this.gradient = const LinearGradient(
      colors: <Color>[
        Palette.firebaseOrange,
        Palette.firebaseAmber,
        Palette.firebaseYellow
      ],
    ),
    this.width = double.infinity,
    this.height = 50.0,
    required this.onPressed,
    this.isActive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
          gradient: isActive ? gradient : null,
          color: isActive ? null : Colors.grey.shade500,
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    offset: const Offset(0.0, 1.5),
                    blurRadius: 1.5,
                  )
                ]
              : null,
          borderRadius: BorderRadius.circular(4)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: isActive ? onPressed : null,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}
