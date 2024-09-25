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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0), // 设置圆角半径为 16.0
        ),
        elevation: 5,
        child: SizedBox(
          width: screenWidth*widthFactor,
          height: screenHeight*heightFactor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * heightFactor * 0.8,
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
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(5.0)), // 圆角
                    image: DecorationImage(
                        image: AssetImage(widget.classifyValue.imageUrl ?? ""),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    height: screenHeight * heightFactor * 0.2,
                    // child: Text(widget.classifyValue.title ?? ""),
                    child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(widget.classifyValue.title ?? "",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ))),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
