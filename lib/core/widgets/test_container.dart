import 'package:flutter/material.dart';

class TestContainer extends StatefulWidget {
  TestContainer({super.key, this.text = ''});

  late String text;

  @override
  State<TestContainer> createState() => _TestContainerState();
}

class _TestContainerState extends State<TestContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      color: Colors.amber,
      child: Text(widget.text),
    );
  }
}