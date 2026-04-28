import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.secondaryNavy,
        selectedItemColor: AppColors.primaryGold,
        unselectedItemColor: AppColors.white,
        selectedFontSize: AppSizes.fontS,
        unselectedFontSize: AppSizes.fontXS,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 28),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard, size: 28),
            label: AppStrings.giftEntry,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people, size: 28),
            label: AppStrings.returnList,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month, size: 28),
            label: AppStrings.calendar,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 28),
            label: AppStrings.settings,
          ),
        ],
      ),
    );
  }
}
