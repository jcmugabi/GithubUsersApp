import 'package:flutter/material.dart';
import '../widgets/navbar.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Github Users',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF000080),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'About this app',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: NavBar(currentIndex: 1),
    );
  }
}
