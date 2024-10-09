import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_learn/model/classify_value.dart';
import 'package:flutter_learn/model/entity.dart';
import 'package:flutter_learn/model/node_value.dart';
import 'package:path_provider/path_provider.dart';

class DataUtil {
  static final _random = Random.secure();

  static const String classifyJsonFile = "classify.json";

  static const String nodeJsonFile = "node.json";

  static String genUid() {
    final now = DateTime.now().millisecondsSinceEpoch;
    final randomPart = _random.nextInt(1000);
    return '$now-$randomPart';
  }

  static Future<List<ClassifyValue>> readAllClassify() async {
    var dir = await getApplicationDocumentsDirectory();
    var path = "${dir.path}/$classifyJsonFile";
    var file = File(path);
    if (!file.existsSync()) {
      return [];
    }
    var jsonString = file.readAsStringSync();
    List<dynamic> list = jsonDecode(jsonString);
    return list.map((e) => ClassifyValue.fromJson(e)).toList();
  }

  static Future<List<ClassifyValue>> insertClassifyFrist(
      List<ClassifyValue>? list, ClassifyValue insert) async {
    var saveList = list ?? [];
    saveList.insert(0, insert);
    var dir = await getApplicationDocumentsDirectory();
    var path = '${dir.path}/$classifyJsonFile';
    var file = File(path);
    file.writeAsStringSync(
        jsonEncode(saveList.map((e) => e.toJson()).toList()));
    
    return saveList;
  }

  static Future<void> saveClassify(List<ClassifyValue> saveList) async{
    var dir = await getApplicationDocumentsDirectory();
    var path = '${dir.path}/$classifyJsonFile';
    var file = File(path);
    file.writeAsStringSync(
        jsonEncode(saveList.map((e) => e.toJson()).toList()));
    
  }

  static Future<Map<String, List<NodeValue>>> readAllNode() async {
    var dir = await getApplicationDocumentsDirectory();
    var path = "${dir.path}/$nodeJsonFile";
    var file = File(path);
    if (!file.existsSync()) {
      return {};
    }
    var jsonString = file.readAsStringSync();
    Map<String, dynamic> list = jsonDecode(jsonString);
    return list.map((k, v) {
      List<dynamic> list = v as List<dynamic>;
      List<NodeValue> nodeList =
          list.map((e) => NodeValue.fromJson(e)).toList();
      return MapEntry(k, nodeList);
    });
  }

  static Future<void> insertNodeFrist(Map<String, List<NodeValue>> map,
      String classifyId, NodeValue insert) async {
    var saveList = map[classifyId] ?? [];
    saveList.insert(0, insert);
    var dir = await getApplicationDocumentsDirectory();
    var path = "$dir/$nodeJsonFile";
    var file = File(path);
    var saveMap =
        map.map((k, v) => MapEntry(k, v.map((e) => e.toJson()).toList()));
    file.writeAsStringSync(jsonEncode(saveMap));
  }

  static List<NodeValue> getNodeValueByClassify(String key) {
    var entities = [
      Entity("1", "images/test.jpg", Entity.IMAGE),
      Entity("2", "images/test2.jpg", Entity.VIDEO, videUrl: "images/h.mp4"),
      Entity("3", "images/test.jpg", Entity.IMAGE),
      Entity("4", "images/test2.jpg", Entity.VIDEO, videUrl: "images/v.mp4"),
      Entity("5", "images/test2.jpg", Entity.IMAGE),
      Entity("6", "images/test.jpg", Entity.VIDEO, videUrl: "images/v.mp4"),
      Entity("7", "images/test.jpg", Entity.IMAGE),
      Entity("8", "images/test2.jpg", Entity.IMAGE)
    ];
    var entities1 = [
      Entity("a", "images/test.jpg", Entity.IMAGE),
      Entity("b", "images/test.jpg", Entity.VIDEO, videUrl: "images/v.mp4"),
      Entity("c", "images/test.jpg", Entity.IMAGE),
      Entity("d", "images/test2.jpg", Entity.VIDEO, videUrl: "images/h.mp4"),
      Entity("e", "images/test2.jpg", Entity.IMAGE),
      Entity("f", "images/test2.jpg", Entity.VIDEO, videUrl: "images/h.mp4"),
    ];
    var entities2 = [
      Entity("a2", "images/test.jpg", Entity.IMAGE),
      Entity("b2", "images/test2.jpg", Entity.VIDEO, videUrl: "images/h.mp4"),
      Entity("c2", "images/test.jpg", Entity.IMAGE),
      Entity("d2", "images/test2.jpg", Entity.VIDEO, videUrl: "images/v.mp4"),
      Entity("e2", "images/test2.jpg", Entity.IMAGE),
      Entity("f2", "images/test.jpg", Entity.VIDEO, videUrl: "images/h.mp4"),
    ];
    var entities3 = [
      Entity("a3", "images/test.jpg", Entity.IMAGE),
      Entity("b3", "images/test2.jpg", Entity.VIDEO, videUrl: "images/h.mp4"),
      Entity("c3", "images/test2.jpg", Entity.IMAGE),
      Entity("d3", "images/test.jpg", Entity.VIDEO, videUrl: "images/v.mp4"),
      Entity("e3", "images/test2.jpg", Entity.IMAGE),
      Entity("f3", "images/test2.jpg", Entity.VIDEO, videUrl: "images/v.mp4"),
    ];
    return [
      NodeValue("node1", entities, "第一天，我们去了这里😄😄"),
      NodeValue("node2", entities1,
          "📌总算把广州给玩明白了 广州好吃、好玩、好逛的6条线路，45个地方。接下来都不怕无聊了🤗 线路：老城区畅玩、畅吃"),
      NodeValue("node3", entities2, "🎵 美好的一天"),
      NodeValue("node4", entities3, "徒步旅🚶")
    ];
  }

  static List<Entity> getEntities() {
    return [
      Entity("9", "images/test.jpg", Entity.IMAGE),
      Entity("10", "images/test2.jpg", Entity.IMAGE),
      Entity("11", "images/test.jpg", Entity.IMAGE),
      Entity("12", "images/test2.jpg", Entity.IMAGE),
      Entity("13", "images/test.jpg", Entity.IMAGE),
      Entity("14", "images/test.jpg", Entity.IMAGE),
      Entity("15", "images/test2.jpg", Entity.IMAGE),
      Entity("16", "images/test.jpg", Entity.IMAGE)
    ];
  }

  static List<Entity> getAllEntities(List<NodeValue> allNodeValues) {
    List<Entity> all = [];
    for (var node in allNodeValues) {
      all.addAll(node.entities);
    }
    return all;
  }

  static int indexOfAll(List<Entity> allEntityValues, Entity entity) {
    int count = 0;
    for (var i = 0; i < allEntityValues.length; i++) {
      if (allEntityValues[i].id == entity.id) {
        count = i;
        break;
      }
    }
    return count;
  }

  static NodeValue? getNodeValueByEntity(
      List<NodeValue> nodeValues, Entity entity) {
    for (var element in nodeValues) {
      for (var e in element.entities) {
        if (e.id == entity.id) {
          return element;
        }
      }
    }
    return null;
  }

  static void saveOrUpdate(NodeValue node, ClassifyValue change) {}

  // static List<ClassifyValue> listTemp() {
  //   return List<ClassifyValue>.generate(4, (i) {
  //     var v = ClassifyValue(
  //         "1",
  //         "广州游记",
  //         (i == 1 || i == 3) ? "images/test2.jpg" : "images/test.jpg",
  //         "2024年9月的一个周末，我门去广州游玩😊😄😄\n 广州市🗺️，简称“穗”，别称羊城、花城、五羊城，广东省辖地级市🚩，是广东省省会、副省级市、国家中心城市、超大城市 [272]，地处中国华南地区，广东省中南部，珠江三角洲的北缘，接近珠江流域下游入海口，总面积7434.40平方千米。 [452]截至2023年10月，广州市下辖11个区。 [1] [69]截至2023年末，广州市常住人口1882.70万人",
  //         "2024年9月21日",
  //         "2024年9月21日");
  //     if (i == 0 || i == 2) {
  //       v.topEntities = DataUtil.getEntities();
  //     }
  //     if (i == 3) {
  //       v.des = null;
  //     }

  //     return v;
  //   });
  // }
}
