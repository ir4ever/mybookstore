import 'package:flutter/material.dart';

class ListViewTitle extends StatelessWidget {
  final bool isVisible;
  final Widget child;
  final String title;
  final double aspectRatio;
  const ListViewTitle({
    super.key,
    required this.child,
    required this.title,
    required this.isVisible,
    required this.aspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: Theme.of(context).textTheme.displayLarge),
          AspectRatio(aspectRatio: aspectRatio, child: child),
        ],
      ),
    );
  }
}
