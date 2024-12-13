import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/components/dimensions.dart';

class Responsive extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const Responsive(
      {super.key,
      required this.webScreenLayout,
      required this.mobileScreenLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        return webScreenLayout;
      }
      return mobileScreenLayout;
    });
  }
}
