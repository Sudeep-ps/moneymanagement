import 'package:flutter/material.dart';
import 'package:moneymanagement/db/category/category_db.dart';
import 'package:moneymanagement/models/category/category_model.dart';

ValueNotifier<CategoryType> selectCategory=ValueNotifier(CategoryType.income);
Future<void> showCategoryAddPopup(BuildContext context) async{
  final _nameeditcontroller = TextEditingController();
  showDialog(
    context: context, 
    builder: (ctx){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SimpleDialog(
          title: const Text('ADD CATEGORY',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                textCapitalization: TextCapitalization.words,
                controller: _nameeditcontroller,
                decoration: const InputDecoration(
                  hintText: 'Category Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25)))
                ),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RadioButton(title: "Income", type: CategoryType.income),
                RadioButton(title: "Expense", type: CategoryType.expense)
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: (){
                  final _name=_nameeditcontroller.text;
                  if(_name.isEmpty){
                    return;
                  }
                  final _type=selectCategory.value;
                  final _category=CategoryModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(), 
                    name: _name, 
                    type: _type,
                  );
                  
                  CategoryDB().insertCategory(_category);
                  Navigator.of(ctx).pop();
                }, 
                child: const Text('Add')
              ),
            )
          ],
        ),
      );
    }
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({super.key,
  required this.title,
  required this.type,  
  });

 

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectCategory, 
          builder: (BuildContext ctx, CategoryType newCategory, Widget? _){
            return Radio<CategoryType>(
              value: type, 
              groupValue: newCategory, 
              onChanged: (value){
              if(value==null){
              return;
              }
              selectCategory.value=value;
              selectCategory.notifyListeners();
              }
            );
          }
        ),
        
        Text(title)
      ],
    );
  }
}