import 'package:flutter/material.dart';

class CustomDragInput extends StatefulWidget {
  const CustomDragInput({super.key});

  @override
  State<CustomDragInput> createState() => _CustomDragInputState();
}

class _CustomDragInputState extends State<CustomDragInput> {
  double _xOffset = 0.0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          _xOffset += details.delta.dx;
        });
      },
      child: Transform.translate(
        offset: Offset(_xOffset, 0),
        child: Draggable(
          child: Container(
            width: 100,
            height: 100,
            color: Colors.blue,
            child: Center(
              child: Text(
                'Drag me!',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          feedback: Container(
            width: 100,
            height: 100,
            color: Colors.blue.withOpacity(0.5),
            child: Center(
              child: Text(
                'Dragging...',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          onDragEnd: (details) {
            setState(() {
              _xOffset = 0.0;
            });
          },
        ),
      ),
    );
  }
}