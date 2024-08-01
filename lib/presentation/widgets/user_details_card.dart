import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/user.dart';
import '../theme/colours.dart';
import '../utils/url_launcher.dart';

class UserDetailsCard extends StatelessWidget {
  final User user;

  const UserDetailsCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 175),
              painter: ArcPainter(),
            ),
            Positioned(
              top: 25,
              left: MediaQuery.of(context).size.width / 2 - 75,
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.avatarUrl),
                radius: 75,
              ),
            ),
          ],
        ),
        const SizedBox(height: 45),
        Text(
          user.name,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          user.login,
          style: const TextStyle(fontSize: 18, color: Color(0xFF000000)),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 1,
          width: MediaQuery.of(context).size.width * 0.85,
          child: Container(
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 20),
        ...[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            user.bio,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(height: 20),
      ],
        ElevatedButton(
          onPressed: () {
            launchUrlInBrowser('https://github.com/${user.login}');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: const Color(0xFFFFFFFF,)
          ),
          child: const Text('VISIT GITHUB PROFILE'),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildInfoColumn('FOLLOWERS', user.followers.toString()),
            _buildInfoColumn('ACCOUNT', user.type),
            _buildInfoColumn('FOLLOWING', user.following.toString()),
          ],
        ),
      ],
    );
  }

  Column _buildInfoColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: AppColors.primaryColor),
        ),
      ],
    );
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryColor
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height)
      ..quadraticBezierTo(size.width / 2, 0, size.width, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
