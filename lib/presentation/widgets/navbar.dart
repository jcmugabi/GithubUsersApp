import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;

  const NavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == 0) {
          Navigator.pushNamed(context, '/users');
        } else {
          Navigator.pushNamed(context, '/about');
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: 'Users',
          backgroundColor: currentIndex == 0 ? Colors.blue : const Color(0xFF000080),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.info),
          label: 'About',
          backgroundColor: currentIndex == 1 ? Colors.blue : const Color(0xFF000080),
        ),
      ],
    );
  }
}
