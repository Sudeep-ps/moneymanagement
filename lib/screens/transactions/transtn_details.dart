import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneymanagement/models/category/category_model.dart';
import 'package:moneymanagement/models/transaction/transaction_model.dart';

Future<void> showTransactionDetails(BuildContext context,TransactionModel currenttransaction) async{
  String parseDate1(DateTime date){
    final newdate = DateFormat.yMMMd().format(date);
    final splitedDate = newdate.split(',');
    final daymonth=splitedDate.first.toString().split(' ');
    return '${daymonth.last}  ${daymonth.first} ${splitedDate.last}';
  }
  showDialog(context: context, builder: (context){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SimpleDialog(
        surfaceTintColor: currenttransaction.type==CategoryType.income ?Colors.green :Colors.red,
        title: const Text("TRANSACTION DETAILS",style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold),),
        children: [
          Text(
                '₹${currenttransaction.amount.toString()}',
                style: const TextStyle(fontSize: 30,fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(currenttransaction.type==CategoryType.income ?'Income\n' :'Expense\n',textAlign: TextAlign.right,style: const TextStyle(fontSize: 15,fontFamily: 'Aclonica'),),
              Text('Description: ${currenttransaction.purpose}',style: const TextStyle(fontSize: 20,fontFamily: 'Prociono')),
              Text('Category : ${currenttransaction.category.name}',style: const TextStyle(fontSize: 20,fontFamily: 'Prociono')),
              Text(parseDate1(currenttransaction.date),style: const TextStyle(fontSize: 20,fontFamily: 'Prociono')),
              
              
            ],
          )  

        ],

      )
    );
  }
  );
  
}