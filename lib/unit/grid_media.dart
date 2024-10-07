import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_learn/model/entity.dart';
import 'package:flutter_learn/util/auto_resize_image.dart';
import 'package:flutter_learn/util/default.dart';

class GridMedia extends StatelessWidget {
  
  final Entity entity;

  const GridMedia({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return _getItem(entity);
  }

  Widget _getItem(Entity entity) {
    if (entity.type == Entity.IMAGE) {
      return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constructors) {
        return Card(
          margin: const EdgeInsets.all(2.0),
          child: Image(
              fit: BoxFit.cover,
              image: AutoResizeImage(
                  imageProvider: FileImage(File.fromRawPath(utf8.encode(entity.url))),
                  width: constructors.maxWidth,
                  height: constructors.maxHeight)),
        );
      });
    } else {
      return Card(
        margin: const EdgeInsets.all(2.0),
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          alignment: AlignmentDirectional.center,
          children: [
            LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constructors) {
              return Image(
                  fit: BoxFit.cover,
                  image: AutoResizeImage(
                      imageProvider: MemoryImage(entity.thumbnailData!),
                      width: constructors.maxWidth,
                      height: constructors.maxHeight));
            }),
            Container(
              alignment: Alignment.center,
              child:
                  Icon(Icons.play_circle, color: Colors.white.withOpacity(0.8)),
            ),
            Container(
              alignment: Alignment.bottomRight,
              margin: const EdgeInsetsDirectional.only(end: 4),
              child: Text(
                DefaultUtil.formatDurationToHMS(entity.duration!),
                style: TextStyle(
                    color: Colors.white.withOpacity(0.8), fontSize: 12),
              ),
            )
          ],
        ),
      );
    }
  }
}
