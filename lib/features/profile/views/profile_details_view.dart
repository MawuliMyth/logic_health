// lib/features/auth/views/profile_details_view.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logic_health/features/auth/widgets/custom_button_widget.dart';
import 'package:logic_health/features/auth/widgets/textfield_widget.dart';
import 'package:logic_health/features/dashboard/widgets/slider_title.dart';
import 'package:provider/provider.dart';

import '../../auth/provider/auth_provider.dart';

class ProfileDetailsView extends StatefulWidget {
  static String id = 'profile_details_view';
  const ProfileDetailsView({super.key});

  @override
  State<ProfileDetailsView> createState() => _ProfileDetailsViewState();
}

class _ProfileDetailsViewState extends State<ProfileDetailsView> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController; // ← permanent controller

  bool _isLoading = false;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();

    final auth = Provider.of<AuthProvider>(context, listen: false);
    final currentName = auth.user?.fullName.trim() ?? '';
    final currentEmail = auth.user?.email ?? '';

    _fullNameController = TextEditingController(text: currentName);
    _emailController = TextEditingController(text: currentEmail);

    // Only listen to full name changes
    _fullNameController.addListener(() {
      final newName = _fullNameController.text.trim();
      final hasChanges = newName != currentName && newName.isNotEmpty;
      if (_hasChanges != hasChanges) {
        setState(() => _hasChanges = hasChanges);
      }
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    if (!_hasChanges || _isLoading) return;

    setState(() => _isLoading = true);

    try {
      final auth = Provider.of<AuthProvider>(context, listen: false);
      await auth.updateUserProfile(fullName: _fullNameController.text.trim());

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Update failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SliderTitle(text: 'Personal Information'),
            const SizedBox(height: 20),

            // Editable Full Name
            TextfieldWidget(
              enabled: true,
              hintText: 'Full Name',
              obscureText: false,
              keyboardType: TextInputType.name,
              controller: _fullNameController,
            ),

            const SizedBox(height: 16),

            // READ-ONLY EMAIL – now truly non-editable
            TextfieldWidget(
              hintText: 'Email',
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              enabled: false,
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: CustomButtonWidget(
                text: _isLoading ? 'Updating...' : 'Update Profile',
                onPressed: _hasChanges && !_isLoading ? _updateProfile : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
