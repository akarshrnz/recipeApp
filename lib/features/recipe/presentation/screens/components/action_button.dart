import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final IconData icon;
  const ActionButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          const SizedBox(width: 10.0),
          Icon(icon),
        ],
      ),
    );
  }
}