import 'package:flutter/material.dart';

class PaisaToggleButton extends StatelessWidget {
  const PaisaToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.blueAccent,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Text'),
          Text('Text'),
        ],
      ),
    );
  }
}
