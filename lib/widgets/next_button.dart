import 'package:flutter/material.dart';

class RectangularButton extends StatelessWidget {
  const RectangularButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.focus,
  });
  final bool focus;
  final VoidCallback? onPressed;
  final String label;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      autofocus: focus,
      onPressed: onPressed,
      child: SizedBox(
        height: 55,
        width: 200,
        child: Card(
          color: onPressed != null ? Colors.white24 : null,
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                letterSpacing: 2,
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
