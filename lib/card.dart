import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_learn/add/classify_add_page.dart';
import 'package:flutter_learn/detail.dart';
import 'package:flutter_learn/model/classify_value.dart';
import 'package:flutter_learn/state/data_state.dart';
import 'package:flutter_learn/util/default.dart';
import 'package:provider/provider.dart';

class CardItem extends StatefulWidget {
  const CardItem({super.key, required this.classifyValue});

  final ClassifyValue classifyValue;

  @override
  State<StatefulWidget> createState() => _CardState();
}

class _CardState extends State<CardItem> {
  final double widthFactor = 0.93; // 设置宽度占屏幕宽度的比例
  final double heightFactor = 0.4; // 设置高度占屏幕高度的比例

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // var image  = Image(image: AssetImage(widget.classifyValue.imageUrl??""));
    return Card(
        color: const Color.fromARGB(255, 255, 255, 255), // 背景颜色
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0), // 设置圆角半径为 5.0
        ),
        elevation: 5,
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Detail(classifyValue: widget.classifyValue)));
            },
            child: SizedBox(
              width: screenWidth * widthFactor,
              height: screenHeight * heightFactor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //图片区
                  SizedBox(
                    height: screenHeight * heightFactor * 0.7,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(5.0)), // 圆角
                        image: DecorationImage(
                            image: FileImage(File.fromRawPath(
                                utf8.encode(widget.classifyValue.imageUrl!))),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  //文字区
                  SizedBox(
                    height: screenHeight * heightFactor * 0.3,
                    width: screenWidth * widthFactor,
                    child: Column(
                      children: [
                        //标题
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 5.0, 0.0, 2.0),
                                child: SizedBox(
                                  width: screenWidth * widthFactor * 0.6,
                                  child: Text(widget.classifyValue.title ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                )),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        10.0, 0.0, 0.0, 0.0),
                                    child: Icon(
                                      Icons.image,
                                      size: 18,
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                          widget.classifyValue.imageCount
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey))),
                                  const Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                    child: Icon(
                                      Icons.play_circle,
                                      size: 18,
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                          widget.classifyValue.videCount
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey))),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        5.0, 0.0, 5.0, 0.0),
                                    child: buildActions(context),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // 创建一个默认样式的分割线
                        const Divider(
                          height: 1,
                          thickness: 1,
                        ),
                        //正文
                        Row(
                          children: [
                            SizedBox(
                              width: screenWidth * widthFactor,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      10.0, 10.0, 5.0, 0.0),
                                  child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      widget.classifyValue.des ?? "",
                                      maxLines: 2,
                                      style: const TextStyle(
                                          // fontWeight: FontWeight.bold,
                                          fontSize: 14))),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }

  Widget buildActions(BuildContext context) {
    return Consumer<DataState>(
      builder: (context, dataState, child) {
        return SizedBox(
          width: 30,
          height: 20,
          child: IconButton(
            padding: const EdgeInsets.all(1),
            onPressed: () {
              var position = DefaultUtil.calPosition(context);
              showMenu<String>(context: context, position: position, items: [
                const PopupMenuItem(
                  value: "edit",
                  child: Text("编辑"),
                ),
                const PopupMenuItem(
                  value: "delete",
                  child: Text("删除"),
                )
              ]).then((value) {
                if (value == 'delete') {
                  showDialog(
                    // ignore: use_build_context_synchronously
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          "⚠️是否要删除相册",
                          style: TextStyle(fontSize: 20),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // 关闭对话框
                            },
                            child: const Text(
                              '取消',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // 这里可以添加确认操作的逻辑
                              dataState
                                  .deleteClassify(widget.classifyValue)
                                  .then(
                                (value) {
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pop(); // 关闭对话框
                                },
                              );
                            },
                            child: const Text(
                              '确认删除',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else if (value == 'edit') {
                  Navigator.push(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClassifyAddPage(
                              classifyValue: widget.classifyValue)));
                }
              });
            },
            icon: const Icon(
              Icons.more_vert,
              size: 18,
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
