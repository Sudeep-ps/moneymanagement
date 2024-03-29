import 'package:flutter/material.dart';
import 'package:moneymanagement/db/category/category_db.dart';
import 'package:moneymanagement/db/transactions/transaction_db.dart';
import 'package:moneymanagement/models/category/category_model.dart';
import 'package:moneymanagement/models/transaction/transaction_model.dart';

class ScreenAddTransaction extends StatefulWidget {
  static const routename='add-transaction';
  const ScreenAddTransaction({super.key});

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {

  
  DateTime? _selecteddate;
  CategoryType? _selectedcategorytype;
  CategoryModel? _selectedcategorymodel; 

  String? _categoryid;

  final _purposeTextEditingController=TextEditingController();
  final _amountTextEditingController=TextEditingController();
  

  @override
  void initState() {
    _selectedcategorytype=CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('   ADD TRANSACTION',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(70,40,70,13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //purpose
              TextFormField(
                textAlign: TextAlign.center,
                controller: _purposeTextEditingController,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  hintText: 'Purpose'
                ),
              ),
              const SizedBox(height: 10,),
              //amount
              TextFormField(
                textAlign: TextAlign.center,
                controller: _amountTextEditingController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  hintText: 'Amount'
                ),
              ),
              const SizedBox(height: 10,),
              //date
              TextButton.icon(
                onPressed: ()async{
                  final selecteddatetemp=await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(const Duration(days: 30)),
                    lastDate: DateTime.now()
                  );
                  if(selecteddatetemp==null){
                    return;
                  }else{
                    //print(selecteddatetemp.toString());
                    setState(() {
                      _selecteddate=selecteddatetemp;
                    });
                  }
                },
                icon: const Icon(Icons.calendar_today), 
                label: Text(
                  _selecteddate==null
                  ? 'Select Date'
                  : _selecteddate.toString(),
                )
              ),
              //income or expense
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                    value: CategoryType.income, 
                    groupValue: _selectedcategorytype, 
                    onChanged: (newvalue){
                      setState(() {
                        _selectedcategorytype=CategoryType.income;
                        _categoryid=null;

                      });                      
                    } 
                  ),
                  const Text("Income"),
                  Radio(
                    value: CategoryType.expense, 
                    groupValue: _selectedcategorytype, 
                    onChanged: (newvalue){
                      setState(() {
                         _selectedcategorytype=CategoryType.expense;
                         _categoryid=null;
                      });                     
                    }
                  ),
                  const Text("Expense"),
                ],
              ),
              //category
              DropdownButton<String>(
                hint: const Text('Select Category'),
                value: _categoryid,
                items: (_selectedcategorytype==CategoryType.income
                          ?CategoryDB().incomecategorylistlistener 
                          :CategoryDB().expensecategorylistlistener)
                        .value.map((e) {
                           return DropdownMenuItem(
                              value: e.id,
                              child: Text(e.name),
                              onTap: (){
                                _selectedcategorymodel=e; 
                              },
                           );
                        }).toList(), 
                onChanged: (selectedvalue){                  
                  //print(selectedvalue);
                  setState(() {
                    _categoryid=selectedvalue;
                  });
                },
                onTap: (){
                  
                },
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: (){
                  addTransaction();
                  Navigator.of(context).pop();
                },   
                child: const Text('Submit'),
              )        
            ],
          ),
        )
      ),
    );
  }

  Future<void> addTransaction() async{
    final purposetext=_purposeTextEditingController.text;
    final amounttext=_amountTextEditingController.text;
    if(purposetext.isEmpty){
      return;
    }
    if(amounttext.isEmpty){
      return;
    }
    if(_selecteddate==null){
      return;
    }
    if(_categoryid==null){
      return;
    }
    if(_selectedcategorymodel==null){
      return;
    }
    final parsedamount = double.tryParse(amounttext);
    if(parsedamount==null){
      return;
    }
    //_selecteddate;
    //_selectedcategorytype;
    //_categoryid;

    final model=TransactionModel(
      purpose: purposetext, 
      amount: parsedamount, 
      date: _selecteddate!, 
      type: _selectedcategorytype!, 
      category: _selectedcategorymodel!,
    );
    TransactionDb.instance.addTransaction(model);

  }
}