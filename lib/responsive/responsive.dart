import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/utils/components/global_variables.dart';

class Responsive extends ConsumerStatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const Responsive(
      {super.key,
      required this.webScreenLayout,
      required this.mobileScreenLayout});

  @override
  ConsumerState<Responsive> createState() => _ResponsiveState();
}

class _ResponsiveState extends ConsumerState<Responsive> {
  @override
  void initState() {
    super.initState();
    addData();
  }
  addData()async{
    await ref.read(userProvider.notifier).refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        return widget.webScreenLayout;
      }
      return widget.mobileScreenLayout;
    });
  }
}
