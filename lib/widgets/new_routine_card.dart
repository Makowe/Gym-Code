import 'package:flutter/material.dart';


class NewRoutineCard extends StatelessWidget {
  final Function add;
  const NewRoutineCard({super.key, required this.add});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
      child: Material(
        color: Colors.blue,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          splashColor: Colors.grey[500],
          child: Row(
            children: [
              const SizedBox(width: 8.0),
              Expanded(
                child: Center(
                  child: Text(
                    'Neue Übung',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[100],
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    add();
                  },
                  icon: const Icon(Icons.add),
                color: Colors.white,
              ),
            ],
          ),
          onTap: () { add(); },
        ),
      ),
    );
  }
}
