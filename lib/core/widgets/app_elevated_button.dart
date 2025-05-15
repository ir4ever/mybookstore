import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final Widget child;
  const AppElevatedButton({super.key, this.isLoading = false, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (isLoading) return;
        onPressed();
      },
      child: isLoading
          ? SizedBox(
              height: 16,
              width: 16,
              child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
            )
          : child,
    );
  }
}
