import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/components/colors.dart';
import 'package:instagram_clone/utils/components/global_variables.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  int _page = 0;
  late PageController pageController;
  void navigationTapped(int page) {
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

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
            onPressed: () {
              navigationTapped(0);
            },
            icon: Icon(
              Icons.home,
              color: _page == 0 ? primaryColor : secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () {
              navigationTapped(1);
            },
            icon: Icon(
              Icons.search,
              color: _page == 1 ? primaryColor : secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () {
              navigationTapped(2);
            },
            icon: Icon(
              Icons.add_a_photo,
              color: _page == 2 ? primaryColor : secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () {
              navigationTapped(3);
            },
            icon: Icon(
              Icons.favorite,
              color: _page == 3 ? primaryColor : secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () {
              navigationTapped(4);
            },
            icon: Icon(
              Icons.person,
              color: _page == 4 ? primaryColor : secondaryColor,
            ),
          ),
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
    );
  }
}
