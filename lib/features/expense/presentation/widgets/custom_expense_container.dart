import 'package:flutter/material.dart';

class CustomExpenseContainer extends StatelessWidget {
  const CustomExpenseContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.25,
      // width: double.infinity,
      width: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 1,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 5,
            spreadRadius: 0,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        children: [
          Column(
            children: [
              Text(
                "Budget for ${DateTime.now().month}",
                style: const TextStyle(
                  color: Colors.white,

                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                '10000',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          ElevatedButton(
            onPressed: () => _opensUpdateBudget(context),
            child: const Text(
              'Update Budget',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _opensUpdateBudget(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height * 0.5,

          child: Column(
            children: [
              const Center(child: Text('set your monthly Budget ')),
              const TextField(keyboardType: TextInputType.numberWithOptions()),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Save Budget',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
