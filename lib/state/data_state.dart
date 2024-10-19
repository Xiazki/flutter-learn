import 'package:flutter/material.dart';
import 'package:flutter_learn/model/classify_value.dart';
import 'package:flutter_learn/model/entity.dart';
import 'package:flutter_learn/model/node_value.dart';
import 'package:flutter_learn/util/data_util.dart';

class DataState with ChangeNotifier {
  bool init = false;
  List<ClassifyValue> classifyValues = [];
  Map<String, List<NodeValue>> nodeMap = {};

  DataState(
      {List<ClassifyValue>? classifyValues,
      Map<String, List<NodeValue>>? nodeMap}) {
    load();
  }

  Future<void> load() async {
    classifyValues = await DataUtil.readAllClassify();
    nodeMap = await DataUtil.readAllNode();
    init = true;
    notifyListeners();
  }

  Future<void> editClassify(ClassifyValue classify) async {
    updateClassifyCount(classify);
    for (int i = 0; i < classifyValues.length; i++) {
      if (classifyValues[i].id == classify.id) {
        classifyValues[i] = classify;

        break;
      }
    }
    await DataUtil.saveClassify(classifyValues);
    notifyListeners();
  }

  Future<void> addClassify(ClassifyValue classify) async {
    updateClassifyCount(classify);
    var newClassifyList =
        await DataUtil.insertClassifyFrist(classifyValues, classify);
    classifyValues = newClassifyList;
    notifyListeners();
  }

  ClassifyValue? getById(String classifyId) {
    ClassifyValue? selectItem;
    for (var element in classifyValues) {
      if (classifyId == element.id) {
        selectItem = element;
        break;
      }
    }
    return selectItem;
  }

  Future<void> deleteClassify(ClassifyValue classify) async {
    ClassifyValue? deleteItem;
    for (var element in classifyValues) {
      if (classify.id == element.id) {
        deleteItem = element;
      }
    }
    if (deleteItem != null) {
      classifyValues.remove(deleteItem);
    }
    await DataUtil.saveClassify(classifyValues);
    notifyListeners();
  }

  Future<void> addNode(String classifyId, NodeValue node) async {
    nodeMap = await DataUtil.insertNodeFrist(nodeMap, classifyId, node);
    updateCountById(classifyId);
    notifyListeners();
  }

  void updateClassifyCount(ClassifyValue classify) {
    int imageCount = 0;
    int videCount = 0;
    if (classify.topEntities != null) {
      for (var entity in classify.topEntities!) {
        if (entity.type == Entity.IMAGE) {
          imageCount++;
        } else if (entity.type == Entity.VIDEO) {
          videCount++;
        }
      }
    }
    var nodeValues = nodeMap[classify.id];
    if (nodeValues != null) {
      for (var node in nodeValues) {
        for (var entity in node.entities) {
          if (entity.type == Entity.IMAGE) {
            imageCount++;
          } else if (entity.type == Entity.VIDEO) {
            videCount++;
          }
        }
      }
    }
    classify.imageCount = imageCount;
    classify.videCount = videCount;
  }

  Future<void> updateCountById(String classifyId) async {
    var classify = getById(classifyId);

    if (classify == null) {
      return;
    }

    updateClassifyCount(classify);

    await DataUtil.saveClassify(classifyValues);
  }

  Future<void> deleteNode(String classifyId, NodeValue node) async {
    nodeMap = await DataUtil.deleteNode(nodeMap, classifyId, node);
    notifyListeners();
  }

  Future<void> updateNode(String classifyId, NodeValue node) async {
    var nodeList = nodeMap[classifyId];
    if (nodeList == null) {
      return;
    }
    for (var i = 0; i < nodeList.length; i++) {
      if (nodeList[i].id == node.id) {
        nodeList[i] = node;
        break;
      }
    }
     updateCountById(classifyId);
    DataUtil.saveNodeMap(nodeMap);
    notifyListeners();
  }
}
