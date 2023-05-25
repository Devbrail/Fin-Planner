import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaisaPillChip extends StatelessWidget {
  const PaisaPillChip({
    super.key,
    required this.title,
    required this.onPressed,
    required this.isSelected,
  });

  final String title;
  final VoidCallback onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final bgColor = Theme.of(context).colorScheme.primaryContainer;
    final textColor = Theme.of(context).colorScheme.primary;
    final borderColor =
        isSelected ? Theme.of(context).colorScheme.primary : null;

    return Row(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: bgColor,
              border: Border.all(
                strokeAlign: BorderSide.strokeAlignInside,
                width: 1.5,
                color: borderColor ?? Colors.white.withOpacity(0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kIsWeb ? 28 : 16,
                vertical: 10,
              ),
              child: Text(
                title,
                style: GoogleFonts.outfit(
                  textStyle: Theme.of(context).textTheme.bodySmall,
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8)
      ],
    );
  }
}
