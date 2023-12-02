import 'package:flutter/material.dart';

class ValueColumn extends StatelessWidget {
  final String value;
  final String description;
  final bool greyedOut;

  const ValueColumn(
      {super.key,
      required this.value,
      required this.description,
      this.greyedOut = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
                fontSize: 24.0,
                color: greyedOut ? Colors.grey[400] : Colors.grey[900]),
          ),
          Text(
            description,
            style: TextStyle(
                fontSize: 12.0,
                color: greyedOut ? Colors.grey[400] : Colors.grey[900]),
          )
        ],
      ),
    );
  }
}
