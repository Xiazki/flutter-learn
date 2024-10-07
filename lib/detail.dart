import 'package:flutter/material.dart';
import 'package:flutter_learn/add/travel_node_add.dart';
import 'package:flutter_learn/model/classify_value.dart';
import 'package:flutter_learn/model/node_value.dart';
import 'package:flutter_learn/node_card.dart';
import 'package:flutter_learn/top_node_card.dart';
import 'package:flutter_learn/util/data_util.dart';

// ignore: must_be_immutable
class Detail extends StatefulWidget {
  ClassifyValue classifyValue;

  Detail({super.key, required this.classifyValue});

  @override
  State<StatefulWidget> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  late List<NodeValue> values;

  @override
  void initState() {
    super.initState();
    values = DataUtil.getNodeValueByClassify(widget.classifyValue.title!);
  }

  void _pressed(){
          Navigator.push(
        context, MaterialPageRoute(builder: (context) => TravelNodeAdd()));
  }

  @override
  Widget build(BuildContext context) {
    var value = widget.classifyValue;
    int count = values.length + 1;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
          elevation: 10,
          onPressed: _pressed,
          tooltip: '创建节点',
          shape: const CircleBorder(),
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          child: const Icon(
            Icons.add_photo_alternate,
            color: Colors.green,
          )),
        body: ListView.builder(
            itemCount: count,
            itemBuilder: (context, index) {
              int i = index - 1;
              if (i == -1) {
                return TopNodeCard(classifyValue: value,);
              
              } else {
                return Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    child:  NodeCard(nodeValue: values[i],allNodeValue: values,indexOfNode: i,));
              }
            }));
  }
}
