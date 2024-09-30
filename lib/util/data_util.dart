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
      Entity("images/test2.jpg", Entity.IMAGE),
      Entity("images/test.jpg", Entity.IMAGE),
      Entity("images/test2.jpg", Entity.IMAGE),
      Entity("images/test.jpg", Entity.IMAGE),
      Entity("images/test.jpg", Entity.IMAGE),
      Entity("images/test2.jpg", Entity.IMAGE),
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

  static List<ClassifyValue> listTemp(){
    return List<ClassifyValue>.generate(4, (i) {
            var v = ClassifyValue(
                "广州游记",
                (i==1||i==3)?"images/test2.jpg": "images/test.jpg",
                "2024年9月的一个周末，我门去广州游玩😊😄😄\n 广州市🗺️，简称“穗”，别称羊城、花城、五羊城，广东省辖地级市🚩，是广东省省会、副省级市、国家中心城市、超大城市 [272]，地处中国华南地区，广东省中南部，珠江三角洲的北缘，接近珠江流域下游入海口，总面积7434.40平方千米。 [452]截至2023年10月，广州市下辖11个区。 [1] [69]截至2023年末，广州市常住人口1882.70万人",
                "2024年9月21日",
                "2024年9月21日");
            v.topEntities = DataUtil.getEntities();
            return v;
          });
  }
}
