import 'package:flutter/material.dart';
import 'package:moneymanagement/db/category/category_db.dart';
import 'package:moneymanagement/models/category/category_model.dart';

class IncomeCategory extends StatelessWidget {
  const IncomeCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB().incomecategorylistlistener, 
      builder: (BuildContext ctx, List<CategoryModel> newlist, Widget? _){
        return ListView.separated(
        itemBuilder: (ctx,index){
          final category=newlist[index];
          return Card(
            child: ListTile(
              title: Text(category.name),
              trailing: IconButton(
                onPressed: (){
                  CategoryDB.instance.deleteCategory(category.id);
                }, 
                icon: const Icon(Icons.delete,color: Colors.red,)
              ),
            ),
          );
        }, 
        separatorBuilder: (ctx,index){
          return const SizedBox(height: 10,);
        }, 
        itemCount: newlist.length
        );
      }
    );
  }
}