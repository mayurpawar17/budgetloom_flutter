import 'package:budgetloom/core/utils/app_color.dart';
import 'package:budgetloom/core/utils/app_logger.dart';
import 'package:budgetloom/core/widgets/common_appbar.dart';
import 'package:budgetloom/core/widgets/custom_text_field.dart';
import 'package:budgetloom/features/expense/presentation/bloc/expense_bloc.dart';
import 'package:budgetloom/features/transcations/data/model/newly_created_expense_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_date_utils.dart';
import '../bloc/expense_event.dart';
import '../bloc/expense_state.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _transactionNameController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    // Clear any old AI analysis data immediately when opening the screen
    Future.microtask(
      () => context.read<ExpenseBloc>().add(ResetExpenseEvent()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpenseBloc, ExpenseState>(
      listener: (context, state) {
        // If error occurs, show snackbar
        if (state.errorMessage != null) {
          AppLogger.instance.i(state.errorMessage!);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
        // If success (loading ends and no error), pop the screen
        if (!state.isLoading &&
            state.errorMessage == null &&
            _transactionNameController.text.isEmpty) {
          // Success logic here (e.g., Navigator.pop(context))
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFBFBFE),
        appBar: const CommonAppBar(title: "Add Expense"),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                const Text(
                  "Capture your wealth flow with natural ease.",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  hint: 'e.g. Swiggy Order 260',
                  controller: _transactionNameController,
                ),
                const SizedBox(height: 20),
                BlocBuilder<ExpenseBloc, ExpenseState>(
                  builder: (context, state) {
                    // Only show the button if we AREN'T loading and DON'T have a response yet
                    if (state.newlyCreatedExpenseResponse != null) {
                      return const SizedBox.shrink();
                    }

                    return IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      onPressed: state.isLoading
                          ? null
                          : () {
                              if (_transactionNameController.text.isNotEmpty) {
                                context.read<ExpenseBloc>().add(
                                  CreateExpenseEvent(
                                    _transactionNameController.text.trim(),
                                  ),
                                );
                                //clean textField
                                _transactionNameController.clear();

                                // Navigator.pop(context); // Go back to dashboard
                              }
                            },
                      icon: const Icon(Icons.auto_awesome, color: Colors.white),
                    );
                  },
                ),
                const SizedBox(height: 20),

                BlocBuilder<ExpenseBloc, ExpenseState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(
                        child: Text("AI is analyzing your expense..."),
                      );
                    }
                    if (state.newlyCreatedExpenseResponse != null) {
                      // Pass the real data to the UI
                      return Column(
                        children: [
                          _buildAIAnalysisSection(
                            state.newlyCreatedExpenseResponse!,
                          ),
                          _buildActionButtons(
                            state.newlyCreatedExpenseResponse,
                            context.read<ExpenseBloc>(),
                            context,
                          ),
                        ],
                      );
                    }
                    // return _buildAIAnalysisSection();

                    return const SizedBox.shrink(); // Show nothing if no data yet
                  },
                ),
                const SizedBox(height: 30),

                // _buildPreviewSection(),
                // const SizedBox(height: 30),
                // _buildActionButtons(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=alex'),
        ),
      ),
      title: const Text(
        "The Fiscal Sanctuary",
        style: TextStyle(
          color: Color(0xFF000066),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications, color: Colors.blueGrey),
        ),
      ],
    );
  }

  Widget _buildInputBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: const Row(
        children: [
          Expanded(
            child: Text(
              "Swiggy order 350",
              style: TextStyle(fontSize: 18, color: Color(0xFF1A1B70)),
            ),
          ),
          Icon(Icons.mic, color: Colors.grey),
          SizedBox(width: 15),
          Icon(Icons.auto_awesome, color: Color(0xFF1A1B70)),
        ],
      ),
    );
  }

  Widget _buildAIAnalysisSection(
    NewlyCreatedExpenseResponse newlyCreatedExpenseResponse,
  ) {
    final data = newlyCreatedExpenseResponse.data;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2).withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.security, size: 16, color: Color(0xFF000066)),
                  SizedBox(width: 8),
                  Text(
                    "AI Analysis",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "DETECTED",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          _buildInfoTile("TITLE", Icons.info, data?.title ?? "N/A"),
          const SizedBox(height: 10),
          _buildInfoTile(
            "CATEGORY",
            Icons.restaurant,
            data?.category?.toUpperCase() ?? "OTHER",
          ),
          const SizedBox(height: 10),
          _buildInfoTile(
            "AMOUNT",
            Icons.currency_rupee,
            data?.amount.toString() ?? "0",
          ),
          const SizedBox(height: 10),
          // Using your reusable DateUtil here!
          _buildInfoTile(
            "DATE",
            Icons.calendar_today,
            AppDateUtil.formatString(data?.createdAt ?? ""),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(String label, IconData icon, String val) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(icon, size: 18),
              const SizedBox(width: 10),
              Text(
                val,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "PREVIEW BEFORE SAVING",
          style: TextStyle(
            fontSize: 12,
            letterSpacing: 1.2,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: const Color(0xFF0D126B),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "TRANSACTION NAME\nSwiggy Order",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "CURRENT BALANCE\n₹12,450.00",
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      _buildTag("PERSONAL"),
                      const SizedBox(width: 8),
                      _buildTag("DINNER"),
                    ],
                  ),
                  const Text(
                    "₹350",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Text(
                "May 24, 2024 • 08:30 PM",
                style: TextStyle(color: Colors.white38, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }

  Widget _buildActionButtons(
    NewlyCreatedExpenseResponse? newlyCreatedExpenseResponse,
    ExpenseBloc bloc,
    context,
  ) {
    // If there is no response yet, you might want to hide these buttons
    if (newlyCreatedExpenseResponse == null) return const SizedBox.shrink();
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              newlyCreatedExpenseResponse = null;
              Navigator.pop(context);
            },
            icon: const Icon(Icons.tune),
            label: const Text("Refine Entry"),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              bloc.add(ResetExpenseEvent()); // No .read() needed here!

              // 2. Simply go back or to Dashboard
              Navigator.pop(context);
            },
            icon: const Icon(Icons.check_circle),
            label: const Text("Confirm Expense"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF000066),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: 1,
      selectedItemColor: const Color(0xFF1A1B70),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "HOME"),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: "ADD"),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics_outlined),
          label: "INSIGHTS",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: "PROFILE",
        ),
      ],
    );
  }
}
