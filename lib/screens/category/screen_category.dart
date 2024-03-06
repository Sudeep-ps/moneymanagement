import 'package:flutter/material.dart';
import 'package:moneymanagement/db/category/category_db.dart';
import 'package:moneymanagement/screens/category/expense_categorylist.dart';
import 'package:moneymanagement/screens/category/income_categorylist.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDB().refreshUI();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(controller: _tabController, tabs: const [
          Tab(text: "INCOME",),
          Tab(text: "EXPENSE",)
        ]),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              IncomeCategory(),
              ExpenseCategory(),
            ]
          ),
        )
      ],
    );
  }
}