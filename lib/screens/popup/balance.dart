import 'package:flutter/material.dart';
import 'package:moneymanagement/db/transactions/transaction_db.dart';
//import 'package:moneymanagement/models/transaction/transaction_model.dart';
double bal=0;
Future<void> showbalanceamount(BuildContext context)async{
  bal=TransactionDb.instance.getbalance();
  showDialog(context: context, builder: (context){
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SimpleDialog(
        
        alignment: const Alignment(0.0,-0.9),
        title: const Text("BALANCE",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
        children: [
          Text("₹ $bal",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.blue.shade900),)
        ],
      ),
    );
  });
}