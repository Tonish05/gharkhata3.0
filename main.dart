import 'package:flutter/material.dart';
import 'signin.dart';
import 'budgetpage.dart';
import 'transaction.dart';
import 'invest.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ghar Khata',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SignInPage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: _buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeSection(),
            const SizedBox(height: 20),
            _buildFinancialSummary(),
            const SizedBox(height: 20),
            _buildFeatureGrid(context), // New Grid Section
            const SizedBox(height: 20),
            const Text(
              "Recent Transactions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(child: _buildTransactionList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add transaction feature
        },
        child: const Icon(Icons.chat),
      ),
    );
  }

  // Welcome Section
  Widget _buildWelcomeSection() {
    return const Text(
      "Welcome, User!",
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  // Financial Summary
  Widget _buildFinancialSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          _SummaryBox(title: "Balance", amount: "₹10,000"),
          _SummaryBox(title: "Income", amount: "₹5,000"),
          _SummaryBox(title: "Expenses", amount: "₹3,000"),
        ],
      ),
    );
  }

  // Feature Grid Section (6 Circular Buttons)
  Widget _buildFeatureGrid(BuildContext context) {
    final List<Map<String, dynamic>> features = [
      {"icon": Icons.swap_horiz, "label": "Transactions", "page": TransactionPage()},
      {"icon": Icons.account_balance_wallet, "label": "Account Balance", "page": AccountBalancePage()},
      {"icon": Icons.receipt_long, "label": "Bills & EMI", "page": BillsEmiPage()},
      {"icon": Icons.trending_up, "label": "Income & Expenses", "page": IncomeExpensesPage()},
      {"icon": Icons.pie_chart, "label": "Budget", "page": BudgetPage()},
      {"icon": Icons.family_restroom, "label": "save & investment ", "page": InvestmentsPage()},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: features.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final feature = features[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => feature["page"]),
            );
          },
          child: Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.deepPurple.shade100,
                child: Icon(feature["icon"], size: 30, color: Colors.deepPurple),
              ),
              const SizedBox(height: 5),
              Text(
                feature["label"],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }

  // Recent Transactions List
  Widget _buildTransactionList() {
    final transactions = [
      {"title": "Grocery", "amount": "-₹500", "color": Colors.red},
      {"title": "Salary", "amount": "+₹5,000", "color": Colors.green},
      {"title": "Electricity Bill", "amount": "-₹1,200", "color": Colors.red},
    ];

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return ListTile(
          title: Text(transaction["title"] as String),
          trailing: Text(
            transaction["amount"] as String,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: transaction["color"] as Color,
            ),
          ),
        );
      },
    );
  }

  // Navigation Drawer
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Text(
              "Ghar Khata",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text("Profile"),
            onTap: () {
              // TODO: Navigate to profile page
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {
              // TODO: Navigate to settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SignInPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Summary Box Widget
class _SummaryBox extends StatelessWidget {
  final String title;
  final String amount;

  const _SummaryBox({required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(amount, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}

// Placeholder Pages (Replace with actual implementations)
/*class TransactionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Transactions")), body: const Center(child: Text("Transactions Page")));
  }
}*/

class AccountBalancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Account Balance")), body: const Center(child: Text("Account Balance Page")));
  }
}

class BillsEmiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Bills & EMI")), body: const Center(child: Text("Bills & EMI Page")));
  }
}

class IncomeExpensesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Income & Expenses")), body: const Center(child: Text("Income & Expenses Page")));
  }
}
/*
class BudgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Budget")), body: const Center(child: Text("Budget Page")));
  }
}*/

/*class FamilyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Family")), body: const Center(child: Text("Family Page")));
  }
}*/

