import 'dart:ui';
import 'package:flutter/material.dart';
import 'transactions_screen.dart';
import 'settings_screen.dart';
import 'user_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (isWide) {
              // ====== LAYOUT DESKTOP / WEB / WINDOWS ======
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    _Sidebar(
                      selectedIndex: selectedIndex,
                      onSelect: (i) => setState(() => selectedIndex = i),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 3,
                      child: _buildMainPanel(),
                    ),
                  ],
                ),
              );
            } else {
              // ====== LAYOUT MOBILE / TABLET ======
              return Column(
                children: [
                  Expanded(child: _buildMainPanel()),
                  _BottomNavBar(
                    selectedIndex: selectedIndex,
                    onSelect: (i) => setState(() => selectedIndex = i),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildMainPanel() {
    return _GlassPanel(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "KoynDex Finance Dashboard",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 18),

                if (selectedIndex == 0 || selectedIndex == 1) ...[
                  _buildKpiRow(),
                  const SizedBox(height: 20),
                ],

                Expanded(
                  child: _buildMainContent(selectedIndex),
                ),
              ],
            ),
          ),

          // ===== BOTÃO DE EXPORTAR PDF =====
          Positioned(
            right: 20,
            bottom: 20,
            child: FloatingActionButton.extended(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: const Color(0xFF2D2D2D),
                    title: const Text("Exportar PDF", style: TextStyle(color: Colors.white)),
                    content: const Text("Relatório exportado com sucesso!",
                        style: TextStyle(color: Colors.white70)),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("OK", style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text("Exportar PDF"),
              backgroundColor: Colors.white.withOpacity(0.15),
              foregroundColor: Colors.white,
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKpiRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          // Layout vertical em telas pequenas
          return Column(
            children: const [
              _KpiCard(label: "Saldo Total", value: "R\$ 500", color: Color(0xFF22C55E)),
              SizedBox(height: 12),
              _KpiCard(label: "Receitas", value: "R\$ 1000", color: Color(0xFFA855F7)),
              SizedBox(height: 12),
              _KpiCard(label: "Despesas", value: "R\$ 500", color: Color(0xFFF87171)),
            ],
          );
        } else {
          // Layout horizontal em telas grandes
          return const Row(
            children: [
              Expanded(
                child: _KpiCard(
                  label: "Saldo Total",
                  value: "R\$ 500",
                  color: Color(0xFF22C55E),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _KpiCard(
                  label: "Receitas",
                  value: "R\$ 1000",
                  color: Color(0xFFA855F7),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _KpiCard(
                  label: "Despesas",
                  value: "R\$ 500",
                  color: Color(0xFFF87171),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildMainContent(int index) {
    switch (index) {
      case 0:
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                _GlassPanel(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Resumo de Transações",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            "Gráficos e resumo geral aparecerão aqui.",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _GlassPanel(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Newsletter",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            "Espaço para novidades e avisos.",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

      case 1:
        return const TransactionsScreen();
      case 3:
        return const UserScreen();
      default:
        return const SettingsScreen();
    }
  }
}

/// ======= SIDEBAR =======
class _Sidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onSelect;

  const _Sidebar({
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.dashboard_outlined, 'label': 'Dashboard'},
      {'icon': Icons.list_alt_outlined, 'label': 'Transações'},
      {'icon': Icons.settings_outlined, 'label': 'Configurações'},
      {'icon': Icons.person_outline, 'label': 'Usuário'},
    ];

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
        child: Container(
          width: 220,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            border: Border.all(color: Colors.white.withOpacity(0.1), width: 1.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Image.asset(
                'assets/images/logo.png',
                width: 80,
                height: 80,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 32),
              for (int i = 0; i < items.length; i++)
                _SidebarItem(
                  icon: items[i]['icon'] as IconData,
                  label: items[i]['label'] as String,
                  selected: selectedIndex == i,
                  onTap: () => onSelect(i),
                ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "v0.0.3-alpha",
                  style: TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ======= BOTTOM NAV (para Mobile) =======
class _BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onSelect;

  const _BottomNavBar({
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black.withOpacity(0.5),
      selectedItemColor: const Color(0xFFA855F7),
      unselectedItemColor: Colors.white54,
      currentIndex: selectedIndex,
      onTap: onSelect,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: "Dashboard"),
        BottomNavigationBarItem(icon: Icon(Icons.list_alt_outlined), label: "Transações"),
        BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: "Configurações"),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Usuário"),
      ],
    );
  }
}

/// ======= COMPONENTES GENÉRICOS =======
class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: selected ? Colors.white.withOpacity(0.12) : Colors.transparent,
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(label, style: const TextStyle(color: Colors.white)),
        onTap: onTap,
      ),
    );
  }
}

class _GlassPanel extends StatelessWidget {
  final Widget child;
  const _GlassPanel({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.1), width: 1.2),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _KpiCard({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.white70, fontSize: 13)),
              const SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  color: color,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
