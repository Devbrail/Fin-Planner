import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/src/core/common.dart';

class PaisaCurrencyWidget extends StatelessWidget {
  const PaisaCurrencyWidget({super.key, required this.number, this.textStyle});

  final double number;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      number.toFormateCurrency(),
      style: textStyle,
    );
  }
}
