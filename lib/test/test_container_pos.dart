import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScrollPositionChecker extends StatefulWidget {
  @override
  _ScrollPositionCheckerState createState() => _ScrollPositionCheckerState();
}

class _ScrollPositionCheckerState extends State<ScrollPositionChecker> {
  final ScrollController _controller = ScrollController();
  final _containerKey = GlobalKey();
  double _containerPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_checkPosition);
  }

  @override
  void dispose() {
    _controller.removeListener(_checkPosition);
    _controller.dispose();
    super.dispose();
  }

  void _checkPosition() {
    // Get the position of the container relative to the scrollable area
    final RenderBox renderBox =
        _containerKey.currentContext!.findRenderObject() as RenderBox;
    final containerPosition = renderBox.localToGlobal(Offset.zero).dy;

    // Get the scroll position
    final scrollPosition = _controller.offset;

    // Calculate the relative position
    final relativePosition = containerPosition - scrollPosition;

    print(containerPosition);

    setState(() {
      // _containerPosition = relativePosition;
      _containerPosition = containerPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scroll Position Checker'),
      ),
      body: Stack(
        children: [
          ListView.builder(
            shrinkWrap: true,
            controller: _controller,
            itemCount: 50,
            itemBuilder: (context, index) {
              if (index == 20) {
                return Container(
                  key: _containerKey,
                  height: 100, // Adjust this according to your container's size
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: Text('Container'),
                );
              }
              return ListTile(title: Text('Item $index'));
            },
          ),
          Visibility(
            visible: _containerPosition < 0,
            child: Container(
              color: Colors.amber,
              height: 100,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Scroll to the container
          _controller.animateTo(
            _containerKey.currentContext!
                .findRenderObject()!
                .getTransformTo(null)
                .getTranslation()
                .y,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        child: Icon(Icons.arrow_downward),
      ),
    );
  }
}
