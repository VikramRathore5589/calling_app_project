import 'package:calling_app_project/bottom_navigation_bar/provider/bottom_navigation_bar_provider.dart';
import 'package:calling_app_project/bottom_navigation_bar/screen/dialpad_screen.dart';
import 'package:calling_app_project/bottom_navigation_bar/screen/profile_screen.dart';
import 'package:calling_app_project/bottom_navigation_bar/screen/reachout_screen.dart';
import 'package:calling_app_project/tabbar/screen/tabbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigationBarScreen extends StatelessWidget {
  BottomNavigationBarScreen({super.key});

  final List<Widget> screensList = [
   TabBarExample(),
    DialPadScreen(),
    ReachOutScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationBarProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                label: '',
                icon: Image.asset('assetss/images/Group 1000005769.png'),
              ),
              BottomNavigationBarItem(
                  label: '',
                  icon: Image.asset('assetss/images/Group 1000005797.png')),
              BottomNavigationBarItem(
                  label: '',
                  icon: Image.asset('assetss/images/Group 1000005735.png')),
              BottomNavigationBarItem(
                  label: '',
                  icon: Image.asset('assetss/images/Group 1000005734.png'))
            ],
            currentIndex: provider.currentIndex,
            onTap: (index) {
              provider.changeValue(index);
            },
          ),
          body: screensList[provider.currentIndex],
        );
      },
    );
  }
}
