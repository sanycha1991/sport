import 'package:flutter/material.dart';
import 'package:sport/pages/checkout/checkout_page.dart';
import 'package:sport/pages/favorites/favorites_page.dart';
import 'package:sport/pages/home/home_page.dart';
import 'package:sport/pages/locations/locations_page.dart';
import 'package:sport/pages/personal/personal_page.dart';
import 'package:sport/pages/shared/navigation_bar.dart';
import '../../extensions/imports.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int bottomSelectedIndex = 0;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void pageChanged(int index) {
    if (index == 3) {
      context.push(const CheckoutPage()).then((value) {
        setState(() {
          bottomSelectedIndex = 0;
          pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        });
      });
      return;
    }
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  Widget buildPageView() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: const <Widget>[
        HomePage(),
        FavoritesPage(),
        LocationsPage(),
        CheckoutPage(),
        PersonalPage(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageView(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: bottomSelectedIndex,
        onSelect: (index) {
          setState(
            () {
              bottomSelectedIndex = index;
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 100),
                curve: Curves.ease,
              );
            },
          );
        },
      ),
    );
  }
}
