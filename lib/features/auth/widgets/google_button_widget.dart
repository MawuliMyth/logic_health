import 'package:flutter/material.dart';

class GoogleButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const GoogleButtonWidget({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 45, child: Image.asset('assets/images/google.png')),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                text,
                style: const TextStyle(color: Color(0xffFF0000)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
