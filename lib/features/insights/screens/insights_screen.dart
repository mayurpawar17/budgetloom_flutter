import 'package:flutter/material.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFE),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 25),
              _buildTopSpendingCard(),
              const SizedBox(height: 15),
              _buildWarningCard(),
              const SizedBox(height: 15),
              _buildSpendingTrendsCard(), // Graph Section
              const SizedBox(height: 15),
              // _buildCoffeeShiftCard(),
              const SizedBox(height: 15),
              // _buildFinancialVitalityCard(),
              const SizedBox(height: 30),
              const Text(
                "Smart Observations",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              _buildObservationTile(
                "Ghost Subscriptions",
                "We detected two dormant streaming services...",
                "\$24.99/mo.",
                Icons.subscriptions,
                const Color(0xFFECECFF),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFFECECFF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.auto_awesome, size: 14, color: Color(0xFF000066)),
              SizedBox(width: 5),
              Text(
                "AI INTELLIGENCE ACTIVE",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000066),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          "Your sanctuary is\nbreathing easy today.",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: Color(0xFF000066),
            height: 1.1,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "We've analyzed 142 transactions from the last 30 days...",
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildTopSpendingCard() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "TOP SPENDING",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Dining & Lifestyle",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "32%",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF000066),
                ),
              ),
              Row(
                children: [
                  Icon(Icons.arrow_upward, size: 16, color: Colors.green),
                  Text(
                    " 4.2% from last month",
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Icon(
              Icons.restaurant,
              size: 80,
              color: Colors.grey.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE0E0),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.warning, color: Color(0xFF660000)),
          const SizedBox(height: 10),
          const Text(
            "Entertainment Burn",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const Text(
            "You've spent 85% of your monthly budget in just 12 days.",
            style: TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF660000),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Center(
              child: Text(
                "ADJUST BUDGET",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpendingTrendsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2).withOpacity(0.5),
        borderRadius: BorderRadius.circular(25),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Spending Trends",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            "Comparison of Net Outflow vs Forecast",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          SizedBox(height: 100), // Placeholder for Chart Widget
          Center(
            child: Text(
              "[Graph Visualization Here]",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  // Helper for Observation List items
  Widget _buildObservationTile(
    String title,
    String desc,
    String trailing,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            child: Icon(icon, color: Colors.indigo),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  desc,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            trailing,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
        ],
      ),
    );
  }

  // ... (AppBar and BottomNav same as previous screens)
}
