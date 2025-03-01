import 'package:flutter/material.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> with SingleTickerProviderStateMixin {
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
        title: const Text("Transactions"),
        backgroundColor: Colors.deepPurple,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Recent Transactions"),
            Tab(text: "Previous Transactions"),
          ],
          indicatorColor: Colors.white,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRecentTransactions(),
          _buildPreviousTransactions(),
        ],
      ),
    );
  }

  Widget _buildRecentTransactions() {
    final List<Map<String, String>> recentTransactions = [
      {"time": "Today, 10:30 AM", "amount": "₹500", "type": "Expense", "category": "Groceries"},
      {"time": "Yesterday, 5:45 PM", "amount": "₹1,200", "type": "Income", "category": "Freelance"},
      {"time": "Yesterday, 2:00 PM", "amount": "₹300", "type": "Expense", "category": "Transport"},
    ];

    return ListView.builder(
      itemCount: recentTransactions.length,
      itemBuilder: (context, index) {
        final transaction = recentTransactions[index];
        return _buildTransactionCard(transaction);
      },
    );
  }

  Widget _buildPreviousTransactions() {
    final List<Map<String, String>> previousTransactions = [
      {"time": "Feb 24, 11:15 AM", "amount": "₹2,000", "type": "Expense", "category": "Rent"},
      {"time": "Feb 23, 9:30 AM", "amount": "₹3,500", "type": "Income", "category": "Salary"},
      {"time": "Feb 22, 6:00 PM", "amount": "₹400", "type": "Expense", "category": "Entertainment"},
    ];

    return ListView.builder(
      itemCount: previousTransactions.length,
      itemBuilder: (context, index) {
        final transaction = previousTransactions[index];
        return _buildTransactionCard(transaction);
      },
    );
  }

  Widget _buildTransactionCard(Map<String, String> transaction) {
    bool isIncome = transaction["type"] == "Income";
    Color color = isIncome ? Colors.green : Colors.red;

    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(isIncome ? Icons.arrow_downward : Icons.arrow_upward, color: color),
        ),
        title: Text("${transaction["category"]} - ${transaction["amount"]}",
            style: TextStyle(fontWeight: FontWeight.bold, color: color)),
        subtitle: Text(transaction["time"]!),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {
          // Navigate to transaction details (Future Enhancement)
        },
      ),
    );
  }
}
