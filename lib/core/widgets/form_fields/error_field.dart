import 'package:flutter/material.dart';

class ErrorField extends StatefulWidget {
  final bool visible;
  final String message;

  const ErrorField({
    super.key,
    this.visible = false,
    this.message = '',
  });

  @override
  State<ErrorField> createState() => _ErrorFieldState();
}

class _ErrorFieldState extends State<ErrorField> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: widget.visible,
        child: Text(
          widget.message,
          style: TextStyle(
            color: Theme.of(context).colorScheme.error,
            fontSize: 12,
          ),
        ));
  }
}
