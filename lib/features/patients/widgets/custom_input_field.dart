import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInputField extends StatefulWidget {
  final String label;
  final String hintText;
  final List<String>? options;
  final TextEditingController? controller;
  final String? value;
  final Function(String?)? onChanged;
  final TextInputType keyboardType;

  const CustomInputField({
    super.key,
    required this.label,
    required this.hintText,
    this.options,
    this.controller,
    this.value,
    this.onChanged,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  OverlayEntry? _overlayEntry;
  final GlobalKey _fieldKey =
      GlobalKey(); // Key to find the position of the box

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showDropdown() {
    _removeOverlay();
    final RenderBox? renderBox =
        _fieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: _removeOverlay,
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            Positioned(
              left: position.dx,
              top: position.dy + size.height + 4, // 4px gap below the field
              width: size.width,
              child: Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 250),
                  decoration: BoxDecoration(
                    color: Color(0xffFFF5F5),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xffE6E6E6)),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: widget.options!.length,
                    itemBuilder: (context, index) {
                      final item = widget.options![index];
                      return ListTile(
                        dense: true,
                        title: Text(
                          item,
                          style: GoogleFonts.poppins(fontSize: 13),
                        ),
                        onTap: () {
                          widget.onChanged?.call(item);
                          _removeOverlay();
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: const Color(0xff000000),
          ),
        ),
        const SizedBox(height: 6),
        widget.options == null ? _buildTextField() : _buildDropdownTrigger(),
        const SizedBox(height: 16),
      ],
    );
  }

  // --- STANDARD TEXTFIELD ---
  Widget _buildTextField() {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      style: GoogleFonts.poppins(fontSize: 13),
      decoration: _inputDecoration(),
    );
  }

  // --- DROPDOWN TRIGGER ---
  Widget _buildDropdownTrigger() {
    return GestureDetector(
      key: _fieldKey, // Assign the key here
      onTap: _showDropdown,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xffE6E6E6)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.value ?? widget.hintText,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: widget.value == null
                    ? const Color(0xff818181)
                    : Colors.black,
              ),
            ),
            const Icon(
              CupertinoIcons.chevron_down,
              color: Color(0xff818181),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      hintText: widget.hintText,
      hintStyle: GoogleFonts.poppins(
        fontSize: 12,
        color: const Color(0xff818181),
      ),

      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xffE6E6E6)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xffE6E6E6)),
      ),
    );
  }
}
