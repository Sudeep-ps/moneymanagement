import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanagement/models/category/category_model.dart';
import 'package:moneymanagement/models/transaction/transaction_model.dart';

const TRANSACTION_DB_NAME="transaction-db";
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
    final _db= await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    _db.put(obj.id,obj);
    refresh();
    
  }

  Future<void> refresh() async{
    final _list = await getAllTransaction();
    _list.sort((first,second)=> second.date.compareTo(first.date));
    transactionlistlistener.value.clear();
    transactionlistlistener.value.addAll(_list);
    transactionlistlistener.notifyListeners();
  }
  
  @override
  Future<List<TransactionModel>> getAllTransaction() async{
    final _db=await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    bal=0;
    _db.values.where((element) => element.type==CategoryType.income).forEach((element) {
      bal=bal+element.amount;
    });
    _db.values.where((element) => element.type==CategoryType.expense).forEach((element) {
      bal=bal-element.amount;
    });
    return _db.values.toList();
  }
  
  @override
  Future<void> deleteTransaction(String id) async{
    final _db=await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.delete(id);
    refresh();
  }
  
  double getbalance() {
    refresh();
    return bal;
  }
  
}