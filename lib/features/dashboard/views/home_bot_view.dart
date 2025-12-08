import 'package:flutter/material.dart';
import 'package:logic_health/features/dashboard/views/dashboard_view.dart';
import 'package:logic_health/features/patients/views/patients_view.dart';
import 'package:logic_health/features/profile/views/profile_view.dart';

import '../widgets/bottom_navigation.dart';

class HomeBotView extends StatefulWidget {
  static String id = 'home_bot_nav';

  const HomeBotView({super.key});

  @override
  State<HomeBotView> createState() => _HomeBotViewState();
}

class _HomeBotViewState extends State<HomeBotView> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    DashboardView(),
    const PatientsView(),
    const ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
