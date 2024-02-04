import 'package:flutter/material.dart';

class RoundedContainer extends StatefulWidget {
  const RoundedContainer({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  State<RoundedContainer> createState() => _RoundedContainerState();
}

class _RoundedContainerState extends State<RoundedContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16),
      child: widget.child ?? const SizedBox(),
    );
  }
}
