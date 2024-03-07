import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const _svgPath = 'assets/images/svg/';

abstract class IconHelper {
  // -------------------- Normal Color --------------------
  static SvgPicture getSVG(String svgName, {Color color = Colors.black}) =>
      SvgPicture.asset(
        '$_svgPath$svgName',
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );

  // -------------------- Gradient --------------------
  static ShaderMask getGradientSVG(
    String svgName, {
    required LinearGradient gradient,
  }) =>
      ShaderMask(
        shaderCallback: (Rect bounds) => gradient.createShader(bounds),
        blendMode: BlendMode.srcATop,
        child: SvgPicture.asset(
          '$_svgPath$svgName',
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      );

  // -------------------- SVG with its Default Color --------------------
  static SvgPicture getSVGDefault(String svgName) =>
      SvgPicture.asset('$_svgPath$svgName');
}