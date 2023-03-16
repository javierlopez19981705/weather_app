import 'package:flutter/material.dart';

import '../utils/spaces.dart';

// ignore: must_be_immutable
class CardInformation extends StatelessWidget {
  CardInformation({
    super.key,
    required this.icon,
    required this.label,
    required this.information,
  });

  IconData icon;
  String label;
  String information;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(241, 241, 241, 1),
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 15,
            ),
            spaceHeight(),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[500],
                overflow: TextOverflow.ellipsis,
              ),
            ),
            spaceHeight(),
            Text(
              information,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
