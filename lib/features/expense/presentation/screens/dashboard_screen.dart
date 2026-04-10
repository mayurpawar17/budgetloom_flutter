import 'package:budgetloom/features/expense/presentation/bloc/expense_bloc.dart';
import 'package:budgetloom/features/expense/presentation/bloc/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_formatter.dart';
import '../bloc/expense_event.dart';
import 'add_expense_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Helper to trigger events
  void _loadData() {
    context.read<ExpenseBloc>().add(GetCurrentMonthTotalEvent());
    context.read<ExpenseBloc>().add(GetCategoryAnalyticsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            _loadData();
            // Wait for the state to stop loading before hiding the spinner
            await context.read<ExpenseBloc>().stream.firstWhere(
              (state) => state.isLoading == false,
            );
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                BlocBuilder<ExpenseBloc, ExpenseState>(
                  builder: (context, state) {
                    if (state.isLoading && state.totalResponse == null) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    // if (state is ExpenseLoading) {
                    //   return const CircularProgressIndicator();
                    // }
                    // if (state is ExpenseLoaded) {
                    //   return _buildTotalSpendingCard(state);
                    // }

                    return Column(
                      children: [
                        // Total Spending Card
                        if (state.totalResponse != null)
                          _buildTotalSpendingCard(state),

                        const SizedBox(height: 20),
                        // Category Analytics Card
                        if (state.categoryResponse != null)
                          _buildSpendingByCategory(state)
                        else if (state.isLoading)
                          const CircularProgressIndicator(), // Loading secondary data

                        if (state.errorMessage != null &&
                            state.totalResponse == null)
                          Text("Error: ${state.errorMessage}"),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),

                // BlocBuilder<ExpenseBloc, ExpenseState>(
                //   builder: (context, state) {
                //     if (state is ExpenseLoading) {
                //       return const CircularProgressIndicator();
                //     }
                //     if (state is CategoryAnalyticsLoaded) {
                //       AppLogger.instance.i("Category State: $state");
                //       return _buildSpendingByCategory(state);
                //     }
                //     return const SizedBox();
                //   },
                // ),
                const SizedBox(height: 20),
                _buildRecentTransactions(),
                const SizedBox(height: 20),
                _buildInsightCard(),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF000066),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddExpenseScreen()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // --- UI Components ---
  Widget _buildTotalSpendingCard(ExpenseState state) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1B70),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TOTAL MONTHLY SPENDING',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),

          Text(
            AppFormatter.formatCurrency(
              state.totalResponse?.data!.totalExpense ?? 0.0,
            ),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.trending_up, color: Colors.greenAccent, size: 16),
                SizedBox(width: 4),
                Text(
                  '12% more than Oct',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpendingByCategory(ExpenseState state) {
    final data = state.categoryResponse?.data;

    if (data == null || data.isEmpty) {
      return const Center(child: Text("No expenses recorded this month."));
    }

    return _buildSectionCard(
      title: "Spending by Category",
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final category = data[index].category?.toUpperCase() ?? "Unknown";
          final amount = AppFormatter.formatCurrency(data[index].amount ?? 0.0);
          final item = data[index];
          return _buildCategoryRow(category, amount, 0.6, Colors.blue);

          // return ListTile(
          //   leading: const Icon(Icons.pie_chart),
          //   title: Text(item.category!.toUpperCase()),
          //   trailing: Text("₹${item.amount?.toStringAsFixed(2)}"),
          // );
        },
      ),
      // child: Column(
      //   children: [
      //     _buildCategoryRow("Food & Dining", "₹18,400", 0.6, Colors.blue),
      //     _buildCategoryRow("Rent & Utilities", "₹22,000", 0.8, Colors.green),
      //     _buildCategoryRow(
      //       "Entertainment",
      //       "₹4,850",
      //       0.3,
      //       Colors.indigoAccent,
      //     ),
      //     _buildCategoryRow("Others", "₹3,000", 0.2, Colors.grey),
      //   ],
      // ),
    );
  }

  Widget _buildRecentTransactions() {
    return _buildSectionCard(
      title: "Recent Transactions",
      child: Column(
        children: [
          _buildTransactionItem(
            Icons.coffee,
            "Starbucks",
            "Nov 14, 2023 • Dining",
            "- ₹450.00",
          ),
          _buildTransactionItem(
            Icons.movie,
            "Netflix",
            "Nov 12, 2023 • Ent.",
            "- ₹649.00",
          ),
          _buildTransactionItem(
            Icons.shopping_basket,
            "BigBasket",
            "Nov 10, 2023 • Shop",
            "- ₹2,100.00",
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF12123B),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Text(
            "You spent 30% more on food this week compared to last.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigoAccent,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {},
            child: const Text(
              "View Recommendations",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets ---
  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Full Report",
                style: TextStyle(color: Colors.blue, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildCategoryRow(
    String label,
    String amount,
    double progress,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontSize: 14)),
              Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            color: color,
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(
    IconData icon,
    String title,
    String sub,
    String price,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: Colors.blue[50],
        child: Icon(icon, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      subtitle: Text(sub, style: const TextStyle(fontSize: 12)),
      trailing: Text(
        price,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
