import 'dart:io';

import 'package:flutter/material.dart';

class Detail extends StatefulWidget{
  
  final String? imageUrl;

  const Detail({super.key, this.imageUrl});

  @override
  State<StatefulWidget> createState() => _DetailState();
}

class _DetailState extends State<Detail>{

  @override
  Widget build(BuildContext context) {
    
    return Container(
      // child: FileImage( File.fromRawPath("rawPath")),
    );
  }
  
}

