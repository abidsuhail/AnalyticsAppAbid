import 'package:flutter/material.dart';

class NotFoundWidget extends StatelessWidget {
  final String txt;

  NotFoundWidget(this.txt);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.not_interested,
          color: Colors.grey,
          size: 35,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          txt,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 18),
        ),
      ],
    ));
  }
}
