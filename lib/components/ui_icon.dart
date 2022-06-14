import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UIIcon extends StatelessWidget {
  final String asset;
  final double? height;
  final double? width;
  final GestureTapCallback? onPressed;

  UIIcon({
    required this.asset,
    this.height,
    this.width,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SvgPicture.asset(
        asset,
        semanticsLabel: asset,
        height: height,
        width: width,
      ),
    );
  }
}
