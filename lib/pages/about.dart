import 'package:flutter/material.dart';
import '../widgets/navbar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Github Users',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF000080),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'About this app',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: const NavBar(currentIndex: 1),
    );
  }
}
