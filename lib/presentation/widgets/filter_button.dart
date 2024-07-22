// For Filter implementation


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class FilterButton extends StatefulWidget {
//   @override
//   _FilterButtonState createState() => _FilterButtonState();
// }
//
// class _FilterButtonState extends State<FilterButton> {
//   String _filterSelection = 'All';
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       child: Text(_filterSelection),
//       onPressed: () {
//         // Show the filter dropdown menu
//         showMenu(
//           context: context,
//           position: RelativeRect.fromLTRB(100, 100, 100, 100), // Adjust the position as needed
//           items: [
//             PopupMenuItem(
//               child: Text('User'),
//               value: 'User',
//             ),
//             PopupMenuItem(
//               child: Text('Organisation'),
//               value: 'Organisation',
//             ),
//           ],
//           elevation: 8.0,
//         ).then((value) {
//           if (value != null) {
//             setState(() {
//               _filterSelection = value;
//             });
//           }
//         });
//       },
//     );
//   }
// }
//
