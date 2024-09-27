import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_learn/model/classify_value.dart';
import 'package:flutter_learn/model/entity.dart';
import 'package:flutter_learn/model/node_value.dart';

class Detail extends StatefulWidget {

  ClassifyValue classifyValue;

  Detail({super.key, required this.classifyValue});


  @override
  State<StatefulWidget> createState() => _DetailState();
}

class _DetailState extends State<Detail> {

  late List<NodeValue> value;
  
  @override
  void initState() {
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // child: FileImage( File.fromRawPath("rawPath")),
        );
  }
}
