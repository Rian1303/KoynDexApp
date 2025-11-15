import 'dart:ui';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool isLoading = false;

  late AnimationController _controller;
  late Animation<double> _anim1;
  late Animation<double> _anim2;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat(reverse: true);
    _anim1 = Tween<double>(begin: -100, end: 100)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _anim2 = Tween<double>(begin: 100, end: -100)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => isLoading = false);
    print("Registrar novo usuário");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width < 1000;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(color: const Color(0xFF1E1E1E)),

          // ==== ANIMAÇÃO DE FUNDO ====
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return Stack(
                children: [
                  _blurCircle(
                    left: _anim1.value,
                    top: 0,
                    color: const Color(0xFF7C3AED).withOpacity(0.35),
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

          // ==== CONTEÚDO ====
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 48,
                vertical: isMobile ? 40 : 60,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isMobile
                      ? 360
                      : isTablet
                          ? 420
                          : 480,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Crie sua conta",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _registerCard(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _registerCard(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 600;

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(isSmall ? 20 : 28),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Preencha os dados abaixo para se registrar",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              _glassInput("Nome completo", _nameCtrl, Icons.person_outline, false),
              const SizedBox(height: 14),
              _glassInput("E-mail", _emailCtrl, Icons.email_outlined, false),
              const SizedBox(height: 14),
              _glassInput("Senha", _passCtrl, Icons.lock_outline, true),
              const SizedBox(height: 14),
              _glassInput("Confirmar senha", _confirmCtrl, Icons.lock_outline, true),
              const SizedBox(height: 24),

              // ==== BOTÃO REGISTRAR ====
              GestureDetector(
                onTap: isLoading ? null : _register,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: isLoading
                          ? [Colors.grey.shade800, Colors.grey.shade700]
                          : const [Color(0xFF7C3AED), Color(0xFFA855F7)],
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
                            "Registrar",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    "Já tem conta? Entrar",
                    style: TextStyle(
                      color: Color(0xFFA855F7),
                      fontWeight: FontWeight.w600,
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

  Widget _glassInput(
      String label, TextEditingController ctrl, IconData icon, bool obscure) {
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
            textInputAction:
                obscure ? TextInputAction.done : TextInputAction.next,
            onSubmitted: (v) {
              if (obscure && !isLoading) _register();
            },
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.white70),
              labelText: label,
              labelStyle:
                  const TextStyle(color: Colors.white70, fontSize: 14),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
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
