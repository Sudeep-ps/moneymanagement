import 'package:flutter/material.dart';
import 'package:moneymanagement/screens/home/screen_home.dart';

class MoneyManagerBottomNavigation extends StatelessWidget {
  const MoneyManagerBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Screenhome.selectedindexnotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget? _){
        return BottomNavigationBar(
        currentIndex: updatedIndex,
        onTap: (newIndex){
          Screenhome.selectedindexnotifier.value=newIndex;
        },
        items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.view_list_rounded),
          label: "TRANSACTIONS"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: "CATEGORY"
        )
      ]);
      },
    );
  }
}