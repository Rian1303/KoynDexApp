import 'dart:ui';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool lightMode = false;
  String currency = 'USD';
  String language = 'English';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width < 1000;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 40,
          vertical: isMobile ? 16 : 24,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isMobile
                  ? 500
                  : isTablet
                      ? 650
                      : 800,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Configurações",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // ====== CONTAINER DE CONFIGURAÇÕES ======
                _GlassContainer(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Preferências do Usuário",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // ===== MODO CLARO =====
                        SwitchListTile(
                          activeColor: const Color(0xFFA855F7),
                          activeTrackColor:
                              const Color(0xFF7C3AED).withOpacity(0.5),
                          title: const Text(
                            "Modo claro",
                            style: TextStyle(color: Colors.white),
                          ),
                          value: lightMode,
                          onChanged: (v) => setState(() => lightMode = v),
                        ),
                        const Divider(color: Colors.white24),

                        // ===== MOEDA =====
                        ListTile(
                          title: const Text(
                            "Moeda",
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            currency,
                            style: const TextStyle(
                                color: Colors.white54, fontSize: 13),
                          ),
                          trailing: const Icon(Icons.chevron_right,
                              color: Colors.white70),
                          onTap: _showCurrencyDialog,
                        ),
                        const Divider(color: Colors.white24),

                        // ===== IDIOMA =====
                        ListTile(
                          title: const Text(
                            "Idioma",
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            language,
                            style: const TextStyle(
                                color: Colors.white54, fontSize: 13),
                          ),
                          trailing: const Icon(Icons.chevron_right,
                              color: Colors.white70),
                          onTap: _showLanguageDialog,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // ===== INFORMAÇÕES DO APP =====
                _GlassContainer(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Sobre o Aplicativo",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          "KoynDex v0.0.3-alpha\n\n"
                          "Um projeto em desenvolvimento que une design e tecnologia "
                          "para transformar dados em entendimento e rotina em fluidez.",
                          style: TextStyle(
                              color: Colors.white60, fontSize: 13, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ======= DIALOGOS =======
  void _showCurrencyDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2C),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          "Selecionar Moeda",
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _currencyOption("R\$ - Real Brasileiro"),
            _currencyOption("US\$ - Dólar Americano"),
            _currencyOption("€ - Euro"),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2C),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          "Selecionar Idioma",
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _languageOption("Português (Brasil)"),
            _languageOption("Inglês (English)"),
            _languageOption("Espanhol (Español)"),
          ],
        ),
      ),
    );
  }

  Widget _currencyOption(String label) => ListTile(
        title: Text(label, style: const TextStyle(color: Colors.white70)),
        onTap: () {
          setState(() => currency = label);
          Navigator.pop(context);
        },
      );

  Widget _languageOption(String label) => ListTile(
        title: Text(label, style: const TextStyle(color: Colors.white70)),
        onTap: () {
          setState(() => language = label);
          Navigator.pop(context);
        },
      );
}

/// ======= CONTAINER VIDRADO REUTILIZÁVEL =======
class _GlassContainer extends StatelessWidget {
  final Widget child;
  const _GlassContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: child,
        ),
      ),
    );
  }
}
