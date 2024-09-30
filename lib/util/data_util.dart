import 'package:flutter_learn/model/classify_value.dart';
import 'package:flutter_learn/model/entity.dart';
import 'package:flutter_learn/model/node_value.dart';

class DataUtil {
  static List<NodeValue> getNodeValueByClassify(String key) {
    var entities = [
      Entity("images/test.jpg", Entity.IMAGE),
      Entity("images/test.jpg", Entity.VIDEO),
      Entity("images/test.jpg", Entity.IMAGE),
      Entity("images/test.jpg", Entity.VIDEO),
      Entity("images/test.jpg", Entity.IMAGE),
      Entity("images/test.jpg", Entity.VIDEO),
      Entity("images/test.jpg", Entity.IMAGE),
      Entity("images/test.jpg", Entity.IMAGE)
    ];
    return [
      NodeValue(entities, "第一天，我们去了这里😄😄"),
      NodeValue(entities, "📌总算把广州给玩明白了 广州好吃、好玩、好逛的6条线路，45个地方。接下来都不怕无聊了🤗 线路：老城区畅玩、畅吃"),
      NodeValue(entities, "🎵 美好的一天"),
      NodeValue(entities, "徒步旅🚶")
    ];
  }

  static List<Entity> getEntities(){
    return [
      Entity("images/test.jpg", Entity.IMAGE),
      Entity("images/test.jpg", Entity.IMAGE),
      Entity("images/test.jpg", Entity.IMAGE),
      Entity("images/test.jpg", Entity.IMAGE),
      Entity("images/test.jpg", Entity.IMAGE),
      Entity("images/test.jpg", Entity.IMAGE),
      Entity("images/test.jpg", Entity.IMAGE),
      Entity("images/test.jpg", Entity.IMAGE)
    ];
  }

  static List<Entity> getAllEntities(List<NodeValue> allNodeValues){
      List<Entity> all = [];
      for (var node in allNodeValues) {
          all.addAll(node.entities);
      }
      return all;
  }

  static int indexOfAll(List<NodeValue> allNodeValues,List<Entity> allEntity,int indexOfAll,int index){
      int count = 0;
      for(var i = 0;i<indexOfAll;i++){
          count = count + allNodeValues[i].entities.length;
      }
      return count+index;
  }
}
