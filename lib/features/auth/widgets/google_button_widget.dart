import 'package:flutter/material.dart';

class GoogleButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const GoogleButtonWidget({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Opacity(
        opacity: onPressed == null ? 0.6 : 1.0,
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
