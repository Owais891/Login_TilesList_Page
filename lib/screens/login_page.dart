import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_textfield.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    required this.authService,
    required this.onAuthenticated,
    super.key,
  });

  final AuthService authService;
  final ValueChanged<String> onAuthenticated;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = true;
  bool _hidePassword = true;
  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });
    try {
      final success = await widget.authService.signIn(
        username: _usernameController.text,
        password: _passwordController.text,
        rememberMe: _rememberMe,
      );
      if (!mounted) return;
      if (success) {
        widget.onAuthenticated('Demo User');
      } else {
        setState(() {
          _errorMessage =
              'Those sign-in details don’t match. Please try again.';
          _isSubmitting = false;
        });
      }
    } on Exception {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Sign-in could not be completed. Please try again.';
        _isSubmitting = false;
      });
    }
  }

  void _showDemoCredentials() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Demo account'),
        content: const Text(
          'Use demo@orbit.app (or demo) as your username and '
          'password123 as your password.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF172543), Color(0xFF263B70)],
                ),
              ),
            ),
          ),
          Positioned(
            top: -100,
            right: -80,
            child: _GlowCircle(
              size: 270,
              color: Colors.white.withValues(alpha: 0.04),
            ),
          ),
          Positioned(
            bottom: -130,
            left: -100,
            child: _GlowCircle(
              size: 310,
              color: const Color(0xFF6D88FF).withValues(alpha: 0.12),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final compact = constraints.maxWidth < 380;
                return Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: compact ? 20 : 28,
                      vertical: 24,
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 450),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const _BrandHeader(),
                          SizedBox(height: compact ? 28 : 38),
                          Container(
                            padding: EdgeInsets.all(compact ? 23 : 30),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x33202C4D),
                                  blurRadius: 35,
                                  offset: Offset(0, 18),
                                ),
                              ],
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome back',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                          color: AppTheme.navy,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: -0.5,
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Sign in to pick up where you left off.',
                                    style: TextStyle(
                                      color: Color(0xFF7C8497),
                                      height: 1.45,
                                    ),
                                  ),
                                  const SizedBox(height: 26),
                                  CustomTextField(
                                    controller: _usernameController,
                                    label: 'Email or username',
                                    hint: 'you@example.com',
                                    icon: Icons.person_outline_rounded,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    validator: (value) =>
                                        value == null || value.trim().isEmpty
                                        ? 'Enter your email or username'
                                        : null,
                                  ),
                                  const SizedBox(height: 16),
                                  CustomTextField(
                                    controller: _passwordController,
                                    label: 'Password',
                                    hint: 'Enter your password',
                                    icon: Icons.lock_outline_rounded,
                                    obscureText: _hidePassword,
                                    textInputAction: TextInputAction.done,
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                        ? 'Enter your password'
                                        : null,
                                    suffix: IconButton(
                                      tooltip: _hidePassword
                                          ? 'Show password'
                                          : 'Hide password',
                                      onPressed: () => setState(
                                        () => _hidePassword = !_hidePassword,
                                      ),
                                      icon: Icon(
                                        _hidePassword
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Checkbox(
                                            value: _rememberMe,
                                            onChanged: (value) => setState(
                                              () =>
                                                  _rememberMe = value ?? false,
                                            ),
                                            visualDensity:
                                                VisualDensity.compact,
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                          ),
                                          const Text(
                                            'Remember me',
                                            style: TextStyle(
                                              color: Color(0xFF596176),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      TextButton(
                                        onPressed: _showDemoCredentials,
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          minimumSize: const Size(0, 40),
                                        ),
                                        child: const Text(
                                          'Forgot password?',
                                          style: TextStyle(fontSize: 11),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (_errorMessage != null) ...[
                                    const SizedBox(height: 4),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFF1F1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        _errorMessage!,
                                        style: const TextStyle(
                                          color: Color(0xFFB63D4A),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                  const SizedBox(height: 18),
                                  SizedBox(
                                    height: 54,
                                    width: double.infinity,
                                    child: FilledButton(
                                      onPressed: _isSubmitting ? null : _signIn,
                                      style: FilledButton.styleFrom(
                                        backgroundColor: AppTheme.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                      ),
                                      child: _isSubmitting
                                          ? const SizedBox(
                                              width: 21,
                                              height: 21,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            )
                                          : const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Sign in',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                Icon(
                                                  Icons.arrow_forward_rounded,
                                                  size: 19,
                                                ),
                                              ],
                                            ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      const Text(
                                        'New to Orbit?',
                                        style: TextStyle(
                                          color: Color(0xFF7C8497),
                                          fontSize: 13,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute<void>(
                                              builder: (_) => SignupPage(
                                                authService: widget.authService,
                                                onAuthenticated:
                                                    widget.onAuthenticated,
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'Create account',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 22),
                          const Text(
                            'A calmer way to manage your day.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFCFD7EC),
                              fontSize: 13,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BrandHeader extends StatelessWidget {
  const _BrandHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 62,
          height: 62,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.13),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
          ),
          child: const Icon(
            Icons.blur_on_rounded,
            color: Colors.white,
            size: 36,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'orbit',
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.3,
          ),
        ),
      ],
    );
  }
}

class _GlowCircle extends StatelessWidget {
  const _GlowCircle({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
