import 'package:flutter/material.dart';
import 'package:flutter_learn/model/entity.dart';

class ClassifyAddPage extends StatefulWidget {
  List<Entity>? firstSelectedEntities;

  ClassifyAddPage({super.key});

  @override
  State<StatefulWidget> createState() => ClassifyAddState();
}

class ClassifyAddState extends State<ClassifyAddPage> {
  double areaFactor = 0.75;
  double buttonFactor = 0.1;

  List<Entity>? _selectedEntities;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
          onPressed: () {
            // 当点击返回按钮时触发的动作
            // 导航回到上一个页面
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // 确保主轴对齐方式正确
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * areaFactor,
                child: Column(
                  children: [
                    _buildSelectedItem(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      child: _buildTitleItem(),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 0.2,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      child: _buildContentItem(),
                    ),
                    const Divider(
                      height: 0.1,
                      thickness: 0.2,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      child: _buildLocationItem(),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * buttonFactor,
                child: _buildCreate(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreate() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(400, 50),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0))),
                onPressed: () {},
                child: const Text("创建相册"))));
  }

  Widget _buildLocationItem() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {},
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start, // 左对齐
            children: [
              Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 20,
              ),
              SizedBox(width: 4.0),
              Text('添加地点'),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTitleItem() {
    return const SizedBox(
      height: 50,
      child: TextField(
        decoration: InputDecoration(
            hintText: "请写一个标题（少于15个字）",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
      ),
    );
  }

  Widget _buildContentItem() {
    return const SizedBox(
      height: 200,
      child: TextField(
        maxLines: 100,
        decoration: InputDecoration(
            hintText: "添加正文，说一些你想说的话吧",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
      ),
    );
  }

  Widget _buildSelectedItem() {
    //  Widget addItem = GestureDetector(
    //     onTap: () {
    //       //todo
    //     },
    //     child: const Card(
    //         margin: EdgeInsets.all(2.0),
    //         child: Icon(
    //           Icons.add,
    //           color: Colors.grey,
    //         )),
    //   );
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(8, (index) {
          return SizedBox(
            width: 200,
            height: 200,
            child: Card(
              margin: const EdgeInsets.all(4.0),
              child: Text("$index"),
            ),
          );
        }),
      ),
    );
    // return GridView.builder(
    //     itemCount: 9,
    //     shrinkWrap: true,
    //     gridDelegate:
    //         SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
    //     itemBuilder: (context, index) {
    //       return SizedBox(
    //         width: 200,
    //         height: 400,
    //         child: Card(
    //           margin: const EdgeInsets.all(4.0),
    //           child: Text("$index"),
    //         ),
    //       );
    //     });
  }
}
