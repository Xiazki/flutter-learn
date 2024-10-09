import 'package:flutter/material.dart';
import 'package:flutter_learn/model/classify_value.dart';
import 'package:flutter_learn/model/node_value.dart';
import 'package:flutter_learn/util/data_util.dart';

class DataState with ChangeNotifier {
  bool init = false;
  List<ClassifyValue> classifyValues = [];
  Map<String, List<NodeValue>> nodeMap = {};

  DataState(
      {List<ClassifyValue>? classifyValues,
      Map<String, List<NodeValue>>? nodeMap}){
        load();
      }

  Future<void> load() async {
    classifyValues = await DataUtil.readAllClassify();
    nodeMap = await DataUtil.readAllNode();
    init = true;
    notifyListeners();
  }

 Future<void> editClassify(ClassifyValue classify) async{
    for(int i = 0;i<classifyValues.length;i++){
      if(classifyValues[i].id == classify.id){
        classifyValues[i] = classify;
        break;
      }
    }
    await DataUtil.saveClassify(classifyValues);
    notifyListeners();
  }

 Future<void> addClassify(ClassifyValue classify) async{
    var newClassifyList =  await DataUtil.insertClassifyFrist(classifyValues, classify);
    classifyValues = newClassifyList;
    notifyListeners();
  }

  Future<void> deleteClassify(ClassifyValue classify) async{
    ClassifyValue? deleteItem;
    for (var element in classifyValues) {
      if(classify.id == element.id){
        deleteItem = element;
      }
    }
    if(deleteItem!=null){
      classifyValues.remove(deleteItem);
    }
    await DataUtil.saveClassify(classifyValues);
    notifyListeners();
  }
}
