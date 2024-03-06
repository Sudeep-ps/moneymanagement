import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanagement/models/category/category_model.dart';

const CAREGORY_DB_NAME="Category-Database";
abstract class CategoryDbFunctions{
  Future<List<CategoryModel>> getCaregories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String categoryID);
}

class CategoryDB implements CategoryDbFunctions{

  CategoryDB._internal();
  static CategoryDB instance = CategoryDB._internal();
  factory CategoryDB(){
    return CategoryDB.instance;
  }

  ValueNotifier<List<CategoryModel>> incomecategorylistlistener=ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expensecategorylistlistener=ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async{
    final _categoryDB=await Hive.openBox<CategoryModel>(CAREGORY_DB_NAME);
    await _categoryDB.put(value.id,value);
    refreshUI();
  }
  
  @override
  Future<List<CategoryModel>> getCaregories() async{
    final _categoryDB=await Hive.openBox<CategoryModel>(CAREGORY_DB_NAME);
    return _categoryDB.values.toList();

  }
  
  @override
  Future<void> deleteCategory(String categoryID) async{
    final _categoryDB=await Hive.openBox<CategoryModel>(CAREGORY_DB_NAME);
    await _categoryDB.delete(categoryID);
    refreshUI();
  }

  Future<void> refreshUI() async{
    final _allcategories=await getCaregories();
    incomecategorylistlistener.value.clear();
    expensecategorylistlistener.value.clear();
    await Future.forEach(
      _allcategories, 
      (CategoryModel category){
        if(category.type==CategoryType.income){
          incomecategorylistlistener.value.add(category);
        }else{
          expensecategorylistlistener.value.add(category);
        }
      }
    );
    incomecategorylistlistener.notifyListeners();
    expensecategorylistlistener.notifyListeners();
  }
  
}