import 'dart:ui';
import 'package:flutter/material.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  bool showForm = false;

  final List<Map<String, dynamic>> _transactions = [
    {
      "title": "Salário",
      "amount": 3500.00,
      "category": "Trabalho",
      "date": "30/10/2025"
    },
    {
      "title": "Aluguel",
      "amount": -1200.00,
      "category": "Moradia",
      "date": "28/10/2025"
    },
    {
      "title": "Café",
      "amount": -18.90,
      "category": "Alimentação",
      "date": "29/10/2025"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width < 1000;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 40,
          vertical: 20,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isMobile
                  ? 600
                  : isTablet
                      ? 800
                      : 1000,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===== CABEÇALHO =====
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Transações",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => setState(() => showForm = !showForm),
                      icon: Icon(showForm ? Icons.close : Icons.add),
                      label:
                          Text(showForm ? "Fechar" : "Nova Transação"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.15),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ===== FORMULÁRIO (RESPONSIVO) =====
                if (showForm)
                  _GlassContainer(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Adicionar Nova Transação (Simulado)",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _inputField("Título"),
                          const SizedBox(height: 8),
                          _inputField("Valor", isNumber: true),
                          const SizedBox(height: 8),
                          _inputField("Categoria"),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.white.withOpacity(0.1),
                                foregroundColor: Colors.white,
                                elevation: 0,
                              ),
                              child: const Text("Salvar (ilustrativo)"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 20),

                // ===== LISTA DE TRANSAÇÕES =====
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _transactions.length,
                  itemBuilder: (context, index) {
                    final t = _transactions[index];
                    return _TransactionCard(
                      title: t["title"],
                      amount: t["amount"],
                      category: t["category"],
                      date: t["date"],
                      isIncome: t["amount"] > 0,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField(String label, {bool isNumber = false}) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white30),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      style: const TextStyle(color: Colors.white),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
    );
  }
}

/// ===== CARD VIDRADO =====
class _GlassContainer extends StatelessWidget {
  final Widget child;
  const _GlassContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: child,
        ),
      ),
    );
  }
}

/// ===== CARD DE TRANSAÇÃO =====
class _TransactionCard extends StatelessWidget {
  final String title;
  final String category;
  final String date;
  final double amount;
  final bool isIncome;

  const _TransactionCard({
    required this.title,
    required this.category,
    required this.date,
    required this.amount,
    required this.isIncome,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: _GlassContainer(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor:
                isIncome ? Colors.green.withOpacity(0.3) : Colors.red.withOpacity(0.3),
            child: Icon(
              isIncome ? Icons.arrow_downward : Icons.arrow_upward,
              color: isIncome ? Colors.greenAccent : Colors.redAccent,
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            "$category • $date",
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
          trailing: Text(
            "${isIncome ? "+" : "-"} R\$ ${amount.abs().toStringAsFixed(2)}",
            style: TextStyle(
              color: isIncome ? Colors.greenAccent : Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
