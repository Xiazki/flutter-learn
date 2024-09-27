import 'package:flutter_learn/model/entity.dart';
import 'package:flutter_learn/model/node_value.dart';

class DataUtil {

  static List<NodeValue> getNodeValueByClassify(String key){
      var entities = [Entity("images/test.jpg", Entity.IMAGE)];
      return [NodeValue(entities, "这是一个测试")];
  }

}