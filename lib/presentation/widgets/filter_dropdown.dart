import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterDropdown extends StatelessWidget {
  final void Function(String?)? onChanged;

  const FilterDropdown({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: [
        DropdownMenuItem(
          child: Text('User'),
          value: 'User',
        ),
        DropdownMenuItem(
          child: Text('Organisation'),
          value: 'Organisation',
        ),
      ],
      onChanged: onChanged,
    );
  }
}
