import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const _svgPath = 'assets/images/svg/';

class IconHelper {
  // ------------------------ normal color --------
  static SvgPicture getSVG(String svgName, {Color color = Colors.black}) =>
      SvgPicture.asset(
        svgName,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );

  // ------------------------- gradient --------------------------
  static ShaderMask getGradientSVG(
    String svgName, {
    required LinearGradient gradient,
  }) =>
      ShaderMask(
        shaderCallback: (Rect bounds) => gradient.createShader(bounds),
        blendMode: BlendMode.srcATop,
        child: SvgPicture.asset(
          '${_svgPath}${svgName}',
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      );
}
