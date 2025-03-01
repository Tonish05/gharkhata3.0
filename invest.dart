import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class InvestmentsPage extends StatefulWidget {
  const InvestmentsPage({Key? key}) : super(key: key);

  @override
  State<InvestmentsPage> createState() => _InvestmentsPageState();
}

class _InvestmentsPageState extends State<InvestmentsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        title: const Text("Investments & Savings"),
        backgroundColor: Colors.deepPurple,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Investment Options"),
            Tab(text: "Financial Literacy"),
            Tab(text: "Savings"),
          ],
          indicatorColor: Colors.white,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildInvestmentOptions(),
          _buildFinancialLiteracy(),
          _buildSavingsOverview(),
        ],
      ),
    );
  }

  Widget _buildInvestmentOptions() {
    final List<Map<String, String>> investments = [
      {"name": "Mutual Funds", "returns": "8-12% p.a."},
      {"name": "Debentures", "returns": "7-10% p.a."},
      {"name": "Government Bonds", "returns": "6-8% p.a."},
      {"name": "Fixed Deposits", "returns": "5-7% p.a."},
      {"name": "PPF (Public Provident Fund)", "returns": "7.1% p.a."},
    ];

    return ListView.builder(
      itemCount: investments.length,
      itemBuilder: (context, index) {
        final investment = investments[index];
        return Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            leading: const Icon(Icons.trending_up, color: Colors.green),
            title: Text(investment["name"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Expected Returns: ${investment["returns"]}"),
          ),
        );
      },
    );
  }

  Widget _buildFinancialLiteracy() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            "Income Distribution Guide",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    value: 50,
                    title: "Expenses (50%)",
                    color: Colors.redAccent,
                    radius: 60,
                  ),
                  PieChartSectionData(
                    value: 30,
                    title: "Savings (30%)",
                    color: Colors.blueAccent,
                    radius: 60,
                  ),
                  PieChartSectionData(
                    value: 20,
                    title: "Investments (20%)",
                    color: Colors.greenAccent,
                    radius: 60,
                  ),
                ],
                sectionsSpace: 2,
                centerSpaceRadius: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavingsOverview() {
    final List<Map<String, dynamic>> monthlySavings = [
      {"month": "January", "savings": 10000},
      {"month": "December", "savings": 8500},
      {"month": "November", "savings": 9200},
      {"month": "October", "savings": 7800},
    ];

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Total Savings Over Time",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        int index = value.toInt();
                        if (index < monthlySavings.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(monthlySavings[index]["month"]!),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: true),
                lineBarsData: [
                  LineChartBarData(
                    spots: monthlySavings
                        .asMap()
                        .entries
                        .map((entry) => FlSpot(entry.key.toDouble(), entry.value["savings"].toDouble()))
                        .toList(),
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 4,
                    belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.3)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
