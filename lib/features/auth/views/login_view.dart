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
          body: Stack(
            children: [
              // Branding/Logo Area (Top)
              Positioned(
                top: 100,
                left: 0,
                right: 0,
                child: Center(
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset('assets/images/logoii.png'),
                  ),
                ),
              ),

              // Auth Content Container (Bottom)
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
                        _buildHeader(),
                        const SizedBox(height: 24),
                        _buildAuthToggle(authProvider),
                        const SizedBox(height: 30),

                        if (authProvider.errorMessage != null)
                          _buildErrorContainer(authProvider.errorMessage!),

                        Form(
                          key: _formKey,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: isSignInActive
                                ? _buildSignInForm(authProvider)
                                : _buildRegisterForm(authProvider),
                          ),
                        ),

                        const SizedBox(height: 20),
                        const DividerWidget(),
                        const SizedBox(height: 20),

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

              // Loading Overlay
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

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          isSignInActive ? 'Welcome back' : 'Create your account',
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Register or sign in to get started',
          style: TextStyle(fontSize: 15, color: Color(0xff818181)),
        ),
      ],
    );
  }

  Widget _buildAuthToggle(AuthProvider authProvider) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xffF6F6F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _toggleButton('Register', !isSignInActive, () {
            setState(() {
              isSignInActive = false;
              authProvider.clearError();
              _formKey.currentState?.reset();
            });
          }),
          _toggleButton('Sign In', isSignInActive, () {
            setState(() {
              isSignInActive = true;
              authProvider.clearError();
              _formKey.currentState?.reset();
            });
          }),
        ],
      ),
    );
  }

  Widget _toggleButton(String text, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: active ? const Color(0xffFF0000) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: active ? Colors.white : Colors.black54,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorContainer(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Text(
        message,
        style: const TextStyle(color: Colors.red, fontSize: 13),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSignInForm(AuthProvider auth) {
    return Column(
      key: const ValueKey('signin'),
      children: [
        TextfieldWidget(
          enabled: !auth.isLoading,
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
          obscureText: false,
          controller: emailController,
          validator: (value) {
            if (value == null || value.isEmpty) return 'Email is required.';
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value))
              return 'Invalid email address.';
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextfieldWidget(
          enabled: !auth.isLoading,
          hintText: 'Password',
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          controller: passwordController,
          validator: (value) {
            if (value == null || value.isEmpty) return 'Password is required.';
            return null;
          },
        ),
        const SizedBox(height: 30),
        CustomButtonWidget(
          text: 'Sign In',
          onPressed: auth.isLoading
              ? null
              : () {
                  if (_formKey.currentState!.validate()) {
                    _handleAsync(() async {
                      auth.clearError();
                      final success = await auth.login(
                        emailController.text.trim(),
                        passwordController.text,
                      );
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
          enabled: !auth.isLoading,
          hintText: 'Full Name',
          keyboardType: TextInputType.name,
          obscureText: false,
          controller: nameController,
          textCapitalization:
              TextCapitalization.words, // Capitalizes "John Doe"
          validator: (value) {
            final name = value?.trim() ?? '';
            if (name.isEmpty) return 'Full name is required.';
            if (name.length < 4) return 'Name must be at least 4 characters.';
            if (!name.contains(' '))
              return 'Please enter both first and last name.';
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextfieldWidget(
          enabled: !auth.isLoading,
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
          obscureText: false,
          controller: emailController,
          validator: (value) {
            if (value == null || value.isEmpty) return 'Email is required.';
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value))
              return 'Invalid email address.';
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextfieldWidget(
          enabled: !auth.isLoading,
          hintText: 'Password',
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          controller: passwordController,
          validator: (value) {
            if (value == null || value.isEmpty) return 'Password is required.';
            if (value.length < 6)
              return 'Password must be at least 6 characters.';
            return null;
          },
        ),
        const SizedBox(height: 30),
        CustomButtonWidget(
          text: 'Register',
          onPressed: auth.isLoading
              ? null
              : () {
                  if (_formKey.currentState!.validate()) {
                    _handleAsync(() async {
                      auth.clearError();
                      final success = await auth.register(
                        nameController.text.trim(),
                        emailController.text.trim(),
                        passwordController.text,
                      );
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
