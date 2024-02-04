import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TestGradientSVG extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShaderMask myGradientMask = ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: [Colors.blue, Colors.green],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcATop, // You can use other blend modes as needed
      child: SvgPicture.asset(
        'assets/images/svg/add_square.svg',
        // You can adjust the color property if needed
        color: Colors.white,
      ),
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('SVG with Gradient'),
        ),
        body: Center(
          child: myGradientMask,
        ),
      ),
    );
  }
}
