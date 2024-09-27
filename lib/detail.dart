import 'package:flutter/material.dart';
import 'package:flutter_learn/model/classify_value.dart';
import 'package:flutter_learn/model/node_value.dart';
import 'package:flutter_learn/node_card.dart';
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
    values = DataUtil.getNodeValueByClassify(widget.classifyValue.title!);
  }

  @override
  Widget build(BuildContext context) {
    var value = widget.classifyValue;
    int count = values.length + 2;
    return Scaffold(
        body: ListView.builder(
            itemCount: count,
            itemBuilder: (context, index) {
              int i = index - 2;
              if (i == -2) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                  child: Text(
                    value.title ?? "",
                    style: const TextStyle(fontSize: 30),
                  ),
                );
              } else if (i == -1) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
                  child: Text(
                    (value.startTime ?? "") + "-" + (value.endTime ?? ""),
                    style: const TextStyle(color: Colors.grey),
                  ),
                );
              } else {
                return Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    child:  NodeCard(nodeValue: values[i]));
              }
            }));
  }
}
