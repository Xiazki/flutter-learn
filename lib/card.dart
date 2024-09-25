import 'package:flutter/material.dart';
import 'package:flutter_learn/model/classify_value.dart';

class CardItem extends StatefulWidget {
  const CardItem({super.key, required this.classifyValue});

  final ClassifyValue classifyValue;

  @override
  State<StatefulWidget> createState() => _CardState();
}

class _CardState extends State<CardItem> {
  final double widthFactor = 0.95; // 设置宽度占屏幕宽度的比例
  final double heightFactor = 0.5; // 设置高度占屏幕高度的比例

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
        child: SizedBox(
          width: screenWidth * widthFactor,
          height: screenHeight * heightFactor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * heightFactor * 0.7,
                // child: ConstrainedBox(
                //   constraints: const BoxConstraints.expand(),
                //   child: Image(fit: BoxFit.cover,image: AssetImage(widget.classifyValue.imageUrl??"")),
                // ),
                // child: ClipRRect(
                //   child: Image(fit: BoxFit.cover,image: AssetImage(widget.classifyValue.imageUrl??"")),
                // ),
                // child: Image(fit: BoxFit.cover,image: AssetImage(widget.classifyValue.imageUrl??"")),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(5.0)), // 圆角
                    image: DecorationImage(
                        image: AssetImage(widget.classifyValue.imageUrl ?? ""),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * heightFactor * 0.3,
                width: screenWidth * widthFactor,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(
                                10.0, 10.0, 10.0, 0.0),
                            child: Text(widget.classifyValue.title ?? "",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13))),
                        // Align(
                        //     alignment: Alignment.centerRight,
                        //     child: Icon(Icons.home)),
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                                child: Icon(
                                  Icons.image,
                                  size: 18,
                                ),
                              ),
                              Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                  child: Text("20",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey))),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(5.0, 10.0, 0.0, 0.0),
                                child: const Icon(
                                  Icons.play_circle,
                                  size: 18,
                                ),
                              ),
                              Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 0.0),
                                  child: Text("5",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey))),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: screenWidth * widthFactor,
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  10.0, 2.0, 10.0, 0.0),
                              child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  widget.classifyValue.des ?? "",
                                  maxLines: 3,
                                  style: const TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 11))),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
