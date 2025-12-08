import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          Expanded(child: Divider(color: const Color(0xffC7C7C7))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: const Text(
              'or continue with',
              style: TextStyle(
                color: Color(0xff000000),
                fontSize: 13,
                fontWeight: FontWeight.w400,
                fontFamily: 'qwerty',
              ),
            ),
          ),
          Expanded(child: Divider(color: const Color(0xffC7C7C7))),
        ],
      ),
    );
  }
}
