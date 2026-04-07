import 'package:budgetloom/features/transcations/bloc/transaction_bloc.dart';
import 'package:budgetloom/features/transcations/data/repo/transaction_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/transaction_event.dart';
import '../bloc/transaction_state.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataBloc(ApiRepository())..add(LoadDataRequested()),
      child: Scaffold(
        backgroundColor: const Color(0xFFFBFBFE),
        body: SafeArea(
          child: BlocBuilder<DataBloc, DataState>(
            builder: (context, state) {
              if (state is DataLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DataLoaded) {
                final transactions = state.allExpensesResponse.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchBar(),
                    _buildFilterChips(),
                    _buildDateHeader("TODAY"),

                    Expanded(
                      child: ListView.builder(
                        itemCount: transactions!.length,
                        itemBuilder: (context, index) {
                          return _buildTransactionTile(
                            transactions![index].title!,
                            transactions[index].createdAt!,
                            transactions[index].amount!,
                            Icons.restaurant,
                            const Color(0xFFECECFF),
                            Colors.redAccent,
                          );
                        },
                      ),
                    ),

                    //
                    // Expanded(
                    //   child: ListView(
                    //     padding: const EdgeInsets.symmetric(horizontal: 16),
                    //     children: [
                    //       _buildTransactionTile(
                    //         "Blue Bottle Coffee",
                    //         "10:45 AM • Dining",
                    //         "-\$12.50",
                    //         Icons.restaurant,
                    //         const Color(0xFFECECFF),
                    //         Colors.redAccent,
                    //       ),
                    //       _buildTransactionTile(
                    //         "Apple Store",
                    //         "09:15 AM • Tech",
                    //         "-\$1,299.00",
                    //         Icons.shopping_bag,
                    //         const Color(0xFFE2FBE5),
                    //         Colors.redAccent,
                    //       ),
                    //
                    //       _buildDateHeader("YESTERDAY"),
                    //       _buildTransactionTile(
                    //         "Metropolitan Transit",
                    //         "06:20 PM • Travel",
                    //         "-\$4.50",
                    //         Icons.directions_bus,
                    //         const Color(0xFFFFEAEA),
                    //         Colors.redAccent,
                    //       ),
                    //       _buildTransactionTile(
                    //         "Dividend Payout",
                    //         "01:00 PM • Investment",
                    //         "+\$420.00",
                    //         Icons.account_balance_wallet,
                    //         const Color(0xFFE2FBE5),
                    //         Colors.green,
                    //       ),
                    //
                    //       _buildDateHeader("NOV 14, 2023"),
                    //       _buildTransactionTile(
                    //         "Monthly Rent",
                    //         "08:00 AM • Housing",
                    //         "-\$2,850.00",
                    //         Icons.home,
                    //         const Color(0xFFF2F2F2),
                    //         Colors.redAccent,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                );
              } else if (state is DataError) {
                return Center(
                  child: Text(
                    state.error,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }
              return const Center(child: Text("Press button to fetch"));
            },
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
        padding: EdgeInsets.all(10.0),
        child: CircleAvatar(
          backgroundColor: Color(0xFF2D140C),
          child: Icon(Icons.person, color: Colors.orange, size: 20),
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
          icon: const Icon(Icons.notifications, color: Color(0xFF000066)),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search your sanctuary...",
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: const Color(0xFFF0F0F0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = ["All", "Food", "Travel", "Shopping"];
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          bool isSelected = index == 0;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Chip(
              backgroundColor: isSelected
                  ? const Color(0xFF000066)
                  : const Color(0xFFF0F0F0),
              label: Text(
                filters[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDateHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 15),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 12,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildTransactionTile(
    String title,
    String subtitle,
    String amount,
    IconData icon,
    Color iconBg,
    Color amountColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: Colors.black87),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: amountColor.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
