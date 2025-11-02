import 'dart:ui';
import 'package:flutter/material.dart';
import 'transactions_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // ===== SIDEBAR =====
            _Sidebar(
              selectedIndex: selectedIndex,
              onSelect: (i) => setState(() => selectedIndex = i),
            ),

            const SizedBox(width: 16),

            // ===== MAIN PANEL =====
            Expanded(
              flex: 3,
              child: _GlassPanel(
                  child: Stack(
                    children: [
                              Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Painel Financeiro",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 18),
              _buildKpiRow(),
              const SizedBox(height: 20),
              Expanded(
                child: Center(
                  child: selectedIndex == 1
                      ? const TransactionsScreen()
                      : Text(
                          selectedIndex == 0
                              ? "Área do grafico e de exportar relatório em PDF"
                              : "⚙️ Configurações do app",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 20,
          bottom: 20,
          child: FloatingActionButton.extended(
            onPressed:(){
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Exportar PDF"),
                  content: const Text("Relatório exportado com sucesso!"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("OK"),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ======== KPIs (Saldo, Receitas, Despesas) ========
  Widget _buildKpiRow() {
    return const Row(
      children: [
        Expanded(
          child: _KpiCard(
            label: "Saldo Total",
            value: "R\$ 0",
            color: Color(0xFF22C55E),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _KpiCard(
            label: "Receitas",
            value: "R\$ 0",
            color: Color(0xFFA855F7),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _KpiCard(
            label: "Despesas",
            value: "R\$ 0",
            color: Color(0xFFF87171),
          ),
        ),
      ],
    );
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
              const Text(
                "LOGOTIPO DO APP",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 32),
              for (int i = 0; i < items.length; i++) ...[
                _SidebarItem(
                  icon: items[i]['icon'] as IconData,
                  label: items[i]['label'] as String,
                  selected: selectedIndex == i,
                  onTap: () => onSelect(i),
                ),
              ],
              const Spacer(),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "v1.0.0",
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

/// ======= ITEM DA SIDEBAR =======
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

/// ======= CARD GLASS GENÉRICO =======
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

/// ======= KPI CARD =======
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
              Text(label,
                  style: const TextStyle(color: Colors.white70, fontSize: 13)),
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
