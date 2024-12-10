import 'package:flutter/material.dart';

class CustomTooltip extends StatelessWidget {
  const CustomTooltip({
    super.key,
    required this.child,
    required this.message,
  });

  final Widget child;

  final String message;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      verticalOffset: 20,
      preferBelow: false,
      showDuration: const Duration(seconds: 2),
      child: child,
    );
  }
}
