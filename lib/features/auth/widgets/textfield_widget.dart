import 'package:flutter/material.dart';

class TextfieldWidget extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool enabled;
  final String? Function(String?)? validator;
  // 💡 Added capitalization support
  final TextCapitalization textCapitalization;

  const TextfieldWidget({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.keyboardType,
    required this.controller,
    required this.enabled,
    this.validator,
    this.textCapitalization = TextCapitalization.none, // Default to none
  });

  @override
  State<TextfieldWidget> createState() => _TextfieldWidgetState();
}

class _TextfieldWidgetState extends State<TextfieldWidget> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      controller: widget.controller,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      // 💡 Apply the capitalization here
      textCapitalization: widget.textCapitalization,

      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),

        // Error Styling
        errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),

        // Default Styling
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xffF6F6F6)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xffF6F6F6)),
        ),
        fillColor: Colors.white,
        filled: true,

        // Password visibility toggle
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: widget.enabled
                    ? () {
                        setState(() => _obscureText = !_obscureText);
                      }
                    : null,
              )
            : null,
      ),
    );
  }
}
