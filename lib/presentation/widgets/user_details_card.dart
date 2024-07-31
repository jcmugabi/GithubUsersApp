import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';

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
              size: Size(MediaQuery.of(context).size.width, 150),
              painter: ArcPainter(),
            ),
            Positioned(
              top: 50,
              left: MediaQuery.of(context).size.width / 2 - 50,
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.avatarUrl),
                radius: 50,
              ),
            ),
          ],
        ),
        const SizedBox(height: 70),
        Text(
          user.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          user.login,
          style: const TextStyle(fontSize: 18, color: Colors.grey),
        ),
        const SizedBox(height: 16),
        ...[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            user.bio,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(height: 16),
      ],
        ElevatedButton(
          onPressed: () {
            (Uri.parse('https://github.com/${user.login}'));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF000080),
          ),
          child: const Text('VISIT GITHUB PROFILE'),
        ),
        const SizedBox(height: 16),
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
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF000080)
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
