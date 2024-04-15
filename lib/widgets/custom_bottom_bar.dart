import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  CustomBottomBar({super.key, required this.pageController});

  final bottomMenuList = [
    BottomMenuModel(
      icon: Icons.home,
      label: "Home",
      type: BottomBarEnum.home,
    ),
    BottomMenuModel(
      icon: Icons.person,
      label: "Profile",
      type: BottomBarEnum.profile,
    ),
  ];

  PageController pageController;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: bottomMenuList
          .map(
            (e) => BottomNavigationBarItem(
              icon: Icon(e.icon, size: 30),
              label: e.label,
            ),
          )
          .toList(),
      onTap: (index) => updateSelectedIndex(index),
    );
  }
}

enum BottomBarEnum {
  home,
  profile,
}

class BottomMenuModel {
  BottomMenuModel({required this.icon, this.label, required this.type});

  IconData icon;

  String? label;

  BottomBarEnum type;
}
