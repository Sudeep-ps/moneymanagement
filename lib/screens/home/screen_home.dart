import 'package:flutter/material.dart';
import 'package:moneymanagement/screens/add_transaction/screen_add_transaction.dart';
import 'package:moneymanagement/screens/popup/about.dart';
import 'package:moneymanagement/screens/popup/balance.dart';
import 'package:moneymanagement/screens/category/category_add_poup.dart';
import 'package:moneymanagement/screens/category/screen_category.dart';
import 'package:moneymanagement/screens/home/widgets/bottomnavigation.dart';
import 'package:moneymanagement/screens/transactions/screen_transaction.dart';

class Screenhome extends StatelessWidget {
  static const routename='home-screen';
  const Screenhome({super.key});


  static ValueNotifier<int> selectedindexnotifier=ValueNotifier(0);
  final _pages = const [
    ScreenTransaction(),
    ScreenCategory()
  ];

  @override
  Widget build(BuildContext context) {
      
    return Scaffold(         
      appBar: AppBar(
        actions: [
          PopupMenuButton(itemBuilder: (context){
            return [
              PopupMenuItem(child: const Text('Check Balance'),onTap: () {
                showbalanceamount(context);                
              },),
              PopupMenuItem(child: const Text('About'),onTap: (){
                Navigator.of(context).pushNamed(AboutPage.routename);
              },)
            ];
          })
        ],
        title: const Text("MONEY MANAGER",style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blue,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedindexnotifier, 
          builder: (BuildContext context,int updatedIndex, _){
            return _pages[updatedIndex];
          }
        )
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: (){
        if(selectedindexnotifier.value==0){
          //print("Add Transactions");
          Navigator.of(context).pushNamed(ScreenAddTransaction.routename);
          
          
        }else{
          //print("Add Category");
          showCategoryAddPopup(context);
          // final _sample=CategoryModel(
          //   id: DateTime.now().millisecondsSinceEpoch.toString(), 
          //   name: 'name', 
          //   type: CategoryType.income
          //   );
          // CategoryDB().insertCategory(_sample);
        }
        
      },
      child: const Icon(Icons.add),
      ),
    );
  }
}