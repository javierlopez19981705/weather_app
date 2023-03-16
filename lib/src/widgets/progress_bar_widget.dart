import 'package:flutter/material.dart';

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: CircularProgressIndicator(),
    );
  }
}
