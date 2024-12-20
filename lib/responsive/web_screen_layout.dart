import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/components/colors.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  PageController pageController = PageController();
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: SvgPicture.asset(
          'asset/images/Instagram-logo-text.svg',
          colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn),
          height: 52,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.home,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_a_photo,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person,
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text('This is web'),
      ),
    );
  }
}
