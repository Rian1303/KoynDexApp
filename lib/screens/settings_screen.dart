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
    return Padding(
      padding: const EdgeInsets.all(20),
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

          _GlassContainer(
            child: Padding(
              padding: const EdgeInsets.all(16),
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
                  SwitchListTile(
                    activeThumbColor: Colors.purpleAccent,
                    title: const Text(
                      "Modo claro",
                      style: TextStyle(color: Colors.white),
                    ),
                    value: lightMode,
                    onChanged: (v) => setState(() => lightMode = v),
                  ),
                  const Divider(color: Colors.white24),

                  ListTile(
                    title: const Text("Moeda",
                    style: TextStyle(color: Colors.white)),
                    subtitle: Text(
                      currency,
                      style: 
                      const  TextStyle(color: Colors.white54, fontSize: 13),
                    ),
                    trailing: const Icon(Icons.chevron_right, color: Colors.white70),
                    onTap:() {
                      _showCurrencyDialog();
                    },
                  ),
                  const Divider(color: Colors.white24),

                  ListTile(
                    title: const Text("Idioma",
                    style: TextStyle(color: Colors.white)),
                    subtitle: Text(
                      language,
                      style:  
                        const TextStyle(color: Colors.white54, fontSize: 13),
                    ),
                    trailing: const Icon(Icons.chevron_right, color: Colors.white70),
                    onTap:() {
                      _showLanguageDialog();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ======= DIALOGOS ILUSTRATIVOS =======
  void _showCurrencyDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2C),
        title: const Text("Selecionar Moeda", style: TextStyle(color: Colors.white)),
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
        title: const Text("Selecionar Idioma", style: TextStyle(color: Colors.white)),
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

/// ======= COMPONENTE GLASS REUTILIZÁVEL =======
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