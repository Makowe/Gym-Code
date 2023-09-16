import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ValueColumn extends StatelessWidget {
  final String value;
  final String description;

  const ValueColumn({super.key, required this.value, required this.description});

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
                fontSize: 30.0,
                color: Colors.grey[900]
            ),
          ),
          Text(
            description,
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[600]
            ),
          )
        ],
      ),
    );
  }
}
