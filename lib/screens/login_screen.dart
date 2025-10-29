import 'dart:ui';
import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  String? errorMsg;
  bool isLoading = false;

  late AnimationController _controller;
  late Animation<double> _anim1;
  late Animation<double> _anim2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 10))
      ..repeat(reverse: true);
    _anim1 = Tween<double>(begin: -100, end: 100)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _anim2 = Tween<double>(begin: 100, end: -100)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() {
      errorMsg = null;
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    if (_emailCtrl.text == "admin" && _passCtrl.text == "1234") {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(PageRouteBuilder(
        pageBuilder: (_, __, ___) => const DashboardScreen(),
        transitionsBuilder: (_, a, __, child) => FadeTransition(opacity: a, child: child),
      ));
    } else {
      setState(() {
        errorMsg = "Usuário ou senha incorretos";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(color: const Color(0xFF1E1E1E)),

          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return Stack(
                children: [
                  _blurCircle(
                    left: _anim1.value,
                    top: 0,
                    color: const Color(0xFF7C3AED).withOpacity(0.4),
                    size: size.width * 0.6,
                  ),
                  _blurCircle(
                    right: _anim2.value,
                    bottom: 0,
                    color: const Color(0xFFA855F7).withOpacity(0.35),
                    size: size.width * 0.7,
                  ),
                ],
              );
            },
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Bem-vindo de volta 👋",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                _loginCard(context),
                if (errorMsg != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    errorMsg!,
                    style: const TextStyle(color: Colors.redAccent, fontSize: 13),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginCard(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: 340,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Acesse sua conta para continuar",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              _glassInput("Usuário ou E-mail", _emailCtrl, Icons.person_outline, false),
              const SizedBox(height: 14),
              _glassInput("Senha", _passCtrl, Icons.lock_outline, true),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: isLoading ? null : _login,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: isLoading
                          ? [Colors.grey.shade800, Colors.grey.shade700]
                          : [const Color(0xFF7C3AED), const Color(0xFFA855F7)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFA855F7).withOpacity(0.4),
                        blurRadius: 25,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Center(
                    child: isLoading
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            "Entrar",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _glassInput(String label, TextEditingController ctrl, IconData icon, bool obscure) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.25)),
          ),
          child: TextField(
            controller: ctrl,
            obscureText: obscure,
            style: const TextStyle(color: Colors.white),
            cursorColor: const Color(0xFFA855F7),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.white70),
              labelText: label,
              labelStyle: const TextStyle(color: Colors.white70, fontSize: 14),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
            ),
          ),
        ),
      ),
    );
  }

  Widget _blurCircle({
    double? left,
    double? right,
    double? top,
    double? bottom,
    required Color color,
    required double size,
  }) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}
