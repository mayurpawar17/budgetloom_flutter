import 'package:budgetloom/core/utils/app_date_utils.dart';
import 'package:budgetloom/features/transcations/bloc/transaction_bloc.dart';
import 'package:budgetloom/features/transcations/data/repo/transaction_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/transaction_event.dart';
import '../bloc/transaction_state.dart';
import '../data/model/category_data.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TransactionBloc(ApiRepository())..add(LoadDataRequested()),
      child: Scaffold(
        backgroundColor: const Color(0xFFFBFBFE),
        body: SafeArea(
          child: BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              if (state is TransactionLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TransactionLoaded) {
                final transactions = state.allExpensesResponse.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchBar(),
                    _buildFilterChips(),
                    // _buildDateHeader("TODAY"),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          // Trigger the load event
                          context.read<TransactionBloc>().add(
                            LoadDataRequested(),
                          );

                          // IMPORTANT: Wait for the next 'Loaded' or 'Error' state
                          // to make the refresh spinner disappear properly.
                          await context
                              .read<TransactionBloc>()
                              .stream
                              .firstWhere(
                                (s) =>
                                    s is TransactionLoaded ||
                                    s is TransactionError,
                              );
                        },
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: transactions!.length,
                          itemBuilder: (context, index) {
                            // Sort the list so the newest dates are at the beginning
                            transactions.sort((a, b) {
                              DateTime dateA = DateTime.parse(a.createdAt!);
                              DateTime dateB = DateTime.parse(b.createdAt!);
                              return dateB.compareTo(
                                dateA,
                              ); // B before A creates descending order (latest first)
                            });
                            final item = transactions[index];
                            final categoryDetail = CategoryMapper.getDetail(
                              item.category,
                            );
                            return _buildTransactionTile(
                              // transactions[index].title!,
                              // // transactions[index].createdAt!,
                              // AppDateUtil.formatString(
                              //   transactions[index].createdAt!,
                              // ),
                              // transactions[index].amount!,
                              // Icons.restaurant,
                              // const Color(0xFFECECFF),
                              // Colors.redAccent,
                              item.title ?? "No Title",
                              AppDateUtil.formatString(item.createdAt ?? ""),
                              item.amount ?? "0.00",
                              categoryDetail.icon, // mapped icon
                              categoryDetail.color, // mapped color
                              Colors.redAccent,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is TransactionError) {
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
    // print("Title : $title Subtitle : $subtitle Amount : $amount ");
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
