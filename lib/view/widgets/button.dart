import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SolidButton extends StatelessWidget {
  final Widget child;
  final Function() onPressed;
  final double? borderRadius;
  final double height;
  final double width;
  final Color? btnColor;
  const SolidButton(
      {Key? key,required this.child,
        required this.onPressed,
        this.borderRadius,
        required this.height,
        required this.width,
        this.btnColor}):super (key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius??5.0)),
        ),
      ),
      child: Ink(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: btnColor??Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius??5.0))),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
