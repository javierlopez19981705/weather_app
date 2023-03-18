import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    super.key,
    required this.backgroundColor,
    required this.onPressed,
    required this.child,
  });

  final void Function()? onPressed;
  final Color? backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed!();
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: backgroundColor,
      ),
      child: child,
    );
  }
}
