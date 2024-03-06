import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanagement/models/category/category_model.dart';
import 'package:moneymanagement/models/transaction/transaction_model.dart';

const transactionDbName="transaction-db";
double bal=0;
abstract class TransactionDbFunctions{
  
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransaction();
  Future<void> deleteTransaction(String id);

}

class TransactionDb implements TransactionDbFunctions{

  TransactionDb._internal();
  static TransactionDb instance=TransactionDb._internal();
  factory TransactionDb(){
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionlistlistener=ValueNotifier([]);


  @override
  Future<void> addTransaction(TransactionModel obj) async{
    final db= await Hive.openBox<TransactionModel>(transactionDbName);
    db.put(obj.id,obj);
    refresh();
    
  }

  Future<void> refresh() async{
    final list = await getAllTransaction();
    list.sort((first,second)=> second.date.compareTo(first.date));
    transactionlistlistener.value.clear();
    transactionlistlistener.value.addAll(list);
    transactionlistlistener.notifyListeners();
  }
  
  @override
  Future<List<TransactionModel>> getAllTransaction() async{
    final db=await Hive.openBox<TransactionModel>(transactionDbName);
    bal=0;
    db.values.where((element) => element.type==CategoryType.income).forEach((element) {
      bal=bal+element.amount;
    });
    db.values.where((element) => element.type==CategoryType.expense).forEach((element) {
      bal=bal-element.amount;
    });
    return db.values.toList();
  }
  
  @override
  Future<void> deleteTransaction(String id) async{
    final db=await Hive.openBox<TransactionModel>(transactionDbName);
    await db.delete(id);
    refresh();
  }
  
  double getbalance() {
    refresh();
    return bal;
  }
  
}