// lib/views/profile_view.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logic_health/features/auth/views/login_view.dart';
import 'package:provider/provider.dart';

import '../../auth/provider/auth_provider.dart';
import 'about_view.dart';
import 'history_view.dart';
import 'privacy_view.dart';
import 'profile_details_view.dart';
import 'terms_view.dart';

class ProfileView extends StatelessWidget {
  static String id = '/profile';

  const ProfileView({super.key});

  void _navigateTo(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: true);
    final fullName = auth.user?.fullName ?? 'Colleague';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logoI.png', height: 50),
                  const SizedBox(width: 8),
                  Text(
                    'Profile',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xff818181), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr.$fullName',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Surgeon',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          'JAC Empire Hospital',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              Expanded(
                child: ListView(
                  children: [
                    _buildMenuItem(
                      context,
                      icon: Icons.person_outline,
                      title: 'Profile Details',
                      onTap: () => _navigateTo(context, ProfileDetailsView.id),
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.history,
                      title: 'History',
                      onTap: () => _navigateTo(context, HistoryView.id),
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.my_library_books_outlined,
                      title: 'Terms and Conditions',
                      onTap: () => _navigateTo(context, TermsView.id),
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.privacy_tip_outlined,
                      title: 'Privacy Policy',
                      onTap: () => _navigateTo(context, PrivacyView.id),
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.info_outline,
                      title: 'About Us',
                      onTap: () => _navigateTo(context, AboutView.id),
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.logout_outlined,
                      title: 'Logout',
                      color: const Color(0xffFF0000),
                      onTap: () {
                        // Show confirmation dialog
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: Color(0xffFF0000),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Logout',
                                  style: GoogleFonts.poppins(
                                    color: Color(0xffFF0000),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            content: const Text(
                              'Are you sure you want to logout?',
                            ),
                            actions: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        side: BorderSide(
                                          color: Color(0xffFF0000),
                                          width: 1.0,
                                        ),
                                      ),
                                      onPressed: () => Navigator.pop(ctx),
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color: Color(0xffFF0000),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xffFF0000),
                                      ),

                                      onPressed: () {
                                        Navigator.pop(ctx);
                                        auth.logout();
                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          LoginView.id,
                                          (route) => false,
                                        );
                                      },
                                      child: const Text(
                                        'Logout',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Menu Item with Divider
  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    Color? color,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: color ?? Colors.grey[700]),
          title: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: color ?? Colors.black87,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey[600],
          ),
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
        ),
        const Divider(height: 1, thickness: 0.8, indent: 56, endIndent: 16),
      ],
    );
  }
}
