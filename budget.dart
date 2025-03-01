import 'package:flutter/material.dart';
import 'main.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({Key? key}) : super(key: key);

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Budget Overview"),
        backgroundColor: Colors.deepPurple,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Current Budget"),
            Tab(text: "Previous Budgets"),
          ],
          indicatorColor: Colors.white,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCurrentBudget(),
          _buildPreviousBudgets(),
        ],
      ),
    );
  }

  Widget _buildCurrentBudget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBudgetCard("Family Income", "₹50,000", Colors.green),
          _buildBudgetCard("Permanent Expenses", "₹20,000", Colors.red),
          _buildBudgetCard("Expected Expenses", "₹10,000", Colors.orange),
          _buildBudgetCard("Savings", "₹15,000", Colors.blue),
          _buildBudgetCard("Smart Budget", "₹5,000", Colors.purple),
          _buildBudgetCard("Required Investment", "₹3,000", Colors.teal),
        ],
      ),
    );
  }

  Widget _buildPreviousBudgets() {
    final List<Map<String, String>> previousBudgets = [
      {"month": "January", "budget": "₹48,000"},
      {"month": "December", "budget": "₹47,000"},
      {"month": "November", "budget": "₹45,500"},
    ];

    return ListView.builder(
      itemCount: previousBudgets.length,
      itemBuilder: (context, index) {
        final budget = previousBudgets[index];
        return Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            leading: const Icon(Icons.history, color: Colors.deepPurple),
            title: Text("Budget for ${budget['month']}"),
            subtitle: Text("Total Budget: ${budget['budget']}"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ),
        );
      },
    );
  }

  Widget _buildBudgetCard(String title, String amount, Color color) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(Icons.account_balance_wallet, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(amount, style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
