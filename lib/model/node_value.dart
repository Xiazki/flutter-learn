import 'package:flutter_learn/model/entity.dart';

class NodeValue {
  NodeValue(this.id, this.entities, this.desc);

  String id;
  List<Entity> entities;
  String desc;
  String? localtion;
  DateTime? dateTime;

  factory NodeValue.fromJson(Map<String, dynamic> jsonMap) {
    List<dynamic> entitiesJsonList = jsonMap["entities"];
    var entities = entitiesJsonList.map((e) => Entity.formJson(e)).toList();
    var nodeValue = NodeValue(jsonMap["id"], entities, jsonMap["desc"]);
    nodeValue.localtion = jsonMap["localtion"];
    var timestamp = jsonMap["dateTime"];
    if(timestamp!=null){
      nodeValue.dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    }
    return nodeValue;
  }

  Map<String,dynamic> toJson(){
    return {
      "id":id,
      "entities":entities.map((e)=>e.toJson()).toList(),
      "desc":desc,
      "localtion":localtion,
      "dateTime":dateTime?.millisecondsSinceEpoch
    };
  }
}
