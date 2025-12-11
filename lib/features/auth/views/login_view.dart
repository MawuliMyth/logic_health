import 'package:flutter/material.dart';
// Widgets
import 'package:logic_health/features/auth/widgets/custom_button_widget.dart';
import 'package:logic_health/features/auth/widgets/divider_widget.dart';
import 'package:logic_health/features/auth/widgets/google_button_widget.dart';
import 'package:logic_health/features/dashboard/views/home_bot_view.dart';
import 'package:provider/provider.dart';

// Provider
import '../provider/auth_provider.dart';
import '../widgets/textfield_widget.dart';

class LoginView extends StatefulWidget {
  static const String id = '/login';

  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isSignInActive = true;

  // 💡 NEW: Global key for form validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _clearFields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  Future<void> _handleAsync(Future<void> Function() callback) async {
    try {
      await callback();
    } catch (e) {
      debugPrint('Unexpected error in _handleAsync: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Scaffold(
          backgroundColor: const Color(0xffFF0000),
          resizeToAvoidBottomInset: true,
          extendBody: true,
          body: Stack(
            children: [
              // Main Container
              Positioned(
                top: 322,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 40),
                    child: Column(
                      children: [
                        // Header
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Text(
                            isSignInActive
                                ? 'Welcome back'
                                : 'Create your account',
                            key: ValueKey(isSignInActive),
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Register or sign in to get started',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff818181),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Register / Sign In Toggle
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xffF6F6F6)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => setState(() {
                                    isSignInActive = false;
                                    authProvider
                                        .clearError(); // Clear error on switch
                                    _formKey.currentState
                                        ?.reset(); // Clear validation errors
                                  }),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isSignInActive
                                          ? Colors.white
                                          : const Color(0xffFFF5F5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Register',
                                      style: TextStyle(
                                        color: isSignInActive
                                            ? Colors.black87
                                            : const Color(0xffFF0000),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => setState(() {
                                    isSignInActive = true;
                                    authProvider
                                        .clearError(); // Clear error on switch
                                    _formKey.currentState
                                        ?.reset(); // Clear validation errors
                                  }),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isSignInActive
                                          ? const Color(0xffF9E1E1)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Sign In',
                                      style: TextStyle(
                                        color: isSignInActive
                                            ? const Color(0xffFF0000)
                                            : Colors.black87,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Error message
                        if (authProvider.errorMessage != null)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              border: Border.all(color: Colors.red.shade200),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              authProvider.errorMessage!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                        // 💡 NEW: Wrap the form switcher in the Global Form widget
                        Form(
                          key: _formKey,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            switchInCurve: Curves.easeOutCubic,
                            switchOutCurve: Curves.easeInCubic,
                            transitionBuilder: (child, animation) {
                              final offset = !isSignInActive
                                  ? const Offset(1.0, 0)
                                  : const Offset(-1.0, 0);
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: offset,
                                  end: Offset.zero,
                                ).animate(animation),
                                child: FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                              );
                            },
                            child: isSignInActive
                                ? _buildSignInForm(authProvider)
                                : _buildRegisterForm(authProvider),
                          ),
                        ),

                        const SizedBox(height: 20),
                        const DividerWidget(),
                        const SizedBox(height: 20),

                        // Google Sign-In Button
                        GoogleButtonWidget(
                          text: authProvider.isLoading
                              ? "Signing in..."
                              : "Google",
                          onPressed: authProvider.isLoading
                              ? null
                              : () {
                                  _handleAsync(() async {
                                    authProvider.clearError();
                                    final success = await authProvider
                                        .signInWithGoogle();
                                    if (success && mounted) {
                                      _clearFields();
                                      Navigator.pushReplacementNamed(
                                        context,
                                        HomeBotView.id,
                                      );
                                    }
                                  });
                                },
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Full-screen loading overlay
              if (authProvider.isLoading)
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: CircularProgressIndicator(color: Color(0xffFF0000)),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSignInForm(AuthProvider auth) {
    return Column(
      key: const ValueKey('signin'),
      children: [
        TextfieldWidget(
          enabled: true,
          hintText: 'Email',
          obscureText: false,
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
          // 💡 NEW: Email validation
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email is required.';
            }
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
              return 'Enter a valid email address.';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextfieldWidget(
          enabled: true,
          hintText: 'Password',
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          controller: passwordController,
          // 💡 NEW: Password validation
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password is required.';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters.';
            }
            return null;
          },
        ),
        const SizedBox(height: 32),
        CustomButtonWidget(
          text: auth.isLoading ? 'Signing In...' : 'Sign In',
          onPressed: auth.isLoading
              ? null
              : () {
                  // 💡 CRITICAL: Validate form before proceeding
                  if (_formKey.currentState!.validate()) {
                    _handleAsync(() async {
                      auth.clearError();
                      final success = await auth.login(
                        emailController.text.trim(),
                        passwordController.text,
                      );
                      // 💡 CRITICAL: Only navigate on successful login
                      if (success && mounted) {
                        _clearFields();
                        Navigator.pushReplacementNamed(context, HomeBotView.id);
                      }
                    });
                  }
                },
        ),
      ],
    );
  }

  Widget _buildRegisterForm(AuthProvider auth) {
    return Column(
      key: const ValueKey('register'),
      children: [
        TextfieldWidget(
          enabled: true,
          hintText: 'Full Name',
          obscureText: false,
          keyboardType: TextInputType.name,
          controller: nameController,
          // 💡 NEW: Name validation
          validator: (value) {
            if (value == null || value.isEmpty || value.trim().length < 2) {
              return 'Full name is required.';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextfieldWidget(
          enabled: true,
          hintText: 'Email',
          obscureText: false,
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
          // 💡 NEW: Email validation
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email is required.';
            }
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
              return 'Enter a valid email address.';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextfieldWidget(
          enabled: true,
          hintText: 'Password',
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          controller: passwordController,
          // 💡 NEW: Password validation
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password is required.';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters.';
            }
            return null;
          },
        ),
        const SizedBox(height: 32),
        CustomButtonWidget(
          text: auth.isLoading ? 'Creating Account...' : 'Register',
          onPressed: auth.isLoading
              ? null
              : () {
                  // 💡 CRITICAL: Validate form before proceeding
                  if (_formKey.currentState!.validate()) {
                    _handleAsync(() async {
                      auth.clearError();
                      final success = await auth.register(
                        nameController.text.trim(),
                        emailController.text.trim(),
                        passwordController.text,
                      );
                      // 💡 CRITICAL: Only navigate on successful registration
                      if (success && mounted) {
                        _clearFields();
                        Navigator.pushReplacementNamed(context, HomeBotView.id);
                      }
                    });
                  }
                },
        ),
      ],
    );
  }
}
