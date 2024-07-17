import 'package:flutter/material.dart';

class Pagination extends StatelessWidget {
  final int currentPage;
  final VoidCallback onPreviousPage;
  final VoidCallback onNextPage;

  const Pagination({
    super.key,
    required this.currentPage,
    required this.onPreviousPage,
    required this.onNextPage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: currentPage > 1 ? onPreviousPage : null,
            child: const Text('Previous'),
          ),
          Text('Page $currentPage'),
          ElevatedButton(
            onPressed: onNextPage,
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
