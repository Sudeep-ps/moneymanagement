import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:moneymanagement/db/category/category_db.dart';
import 'package:moneymanagement/db/transactions/transaction_db.dart';
import 'package:moneymanagement/models/category/category_model.dart';
import 'package:moneymanagement/models/transaction/transaction_model.dart';
import 'package:moneymanagement/screens/transactions/transtn_details.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refresh();
    CategoryDB.instance.refreshUI();
    return ValueListenableBuilder(
      valueListenable: TransactionDb.instance.transactionlistlistener, 
      builder: (BuildContext ctx, List<TransactionModel> newlist, Widget? _){
        return ListView.separated(
          padding: const EdgeInsets.all(10),
          itemBuilder: (ctx,index){
            final value=newlist[index];
            return  Slidable(
              key: Key(value.id!),
              startActionPane: ActionPane(
                motion: const ScrollMotion(), 
                children: [
                  SlidableAction(
                    onPressed: (ctx){
                      TransactionDb.instance.deleteTransaction(value.id!);
                    },
                    icon: Icons.delete,
                  )
                ]
              ),
              child: Card(
                elevation: 0,
                child: ListTile(                                      
                  leading: CircleAvatar(                                           
                   backgroundColor: Colors.lightBlue,
                   radius: 30,                      
                   child: value.type==CategoryType.income ?Image.asset('assets/images/income.jpg') :Image.asset('assets/images/expense.jpg'),//Text(parseDate(_value.date),textAlign: TextAlign.center,style: const TextStyle(color: Colors.white),),
                  ),
                  title: Text(
                    value.type==CategoryType.income ?"+ ₹${value.amount.toString()}" :"- ₹${value.amount.toString()}",
                    style: TextStyle(fontWeight: FontWeight.bold ,color: value.type==CategoryType.income ?Colors.green :Colors.red),
                  ),
                  subtitle: Text(value.category.name),
                  onTap: () {
                    showTransactionDetails(context, value);
                  },
                  trailing: Text(parseDate(value.date)),
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

  String parseDate(DateTime date){
    final newdate = DateFormat.MMMd().format(date);
    final splitedDate = newdate.split(' ');
    return '${splitedDate.last}\n${splitedDate.first}';
  }
}