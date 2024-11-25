import 'package:employees_today/core/configs/assets/app_vectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DecorationWrapper extends StatelessWidget {
  final Widget child;
  final Widget? appBar;

  const DecorationWrapper({super.key, required this.child, this.appBar});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          child: SizedBox(
            width: 180,
            height: 400,
            child: SvgPicture.asset(
              AppVectors.scaffoldTopLeft,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: SizedBox(
            width: 300,
            height: 450,
            child: SvgPicture.asset(
              AppVectors.scaffoldBottomLeft,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              appBar ?? const SizedBox(),
              child,
            ],
          ),
        ),
      ],
    );
  }
}
