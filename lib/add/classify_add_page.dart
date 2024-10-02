import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_learn/model/entity.dart';
import 'package:flutter_learn/unit/grid_media.dart';
import 'package:flutter_learn/util/auto_resize_image.dart';
import 'package:flutter_learn/util/data_util.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

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
                    _buildSelectedItem(_selectedEntities),
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

  Widget _buildSelectedItem(List<Entity>? entities) {
    List<Widget> list = [];
    var addItemButton = SizedBox(
      width: 200,
      height: 200,
      child: GestureDetector(
          onTap: selectAssets,
          child: const Card(
            // color: Colors.grey,
            margin: EdgeInsets.all(4.0),
            child: Icon(
              Icons.add_photo_alternate,
              color: Colors.green,
              size: 40,
            ),
          )),
    );
    if (entities == null) {
      list.add(addItemButton);
    } else {
      for (var item in entities) {
        list.add(SizedBox(
            width: 200,
            height: 200,
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constructors) {
              return Container(
                margin: const EdgeInsets.all(2.0),
                // elevation: 5,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AutoResizeImage(
                            imageProvider: FileImage(
                                File.fromRawPath(utf8.encode(item.url))),
                            width: constructors.maxWidth,
                            height: constructors.maxHeight))),
                child: Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: IconButton(
                      onPressed: (){delete(item);},
                      icon: const Icon(Icons.close,color: Colors.black54,),
                      
                      iconSize: 15,
                      padding: const EdgeInsets.all(1.0),
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Colors.red)),
                    ),
                  ),
                ),
              );
            })));
      }
      if (entities.length < 9) {
        list.add(addItemButton);
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: list,
      ),
    );
  }

  void delete(Entity entity){
      setState(() {
        if(_selectedEntities!=null){
          _selectedEntities!.remove(entity);
        }
      });
  }

  Future<void> selectAssets() async {
    int limit = 9;
    if (_selectedEntities != null) {
      int c = _selectedEntities!.length;
      limit = limit - c;
    }
    if (limit <= 0) {
      return;
    }
    List<AssetEntity>? result = await AssetPicker.pickAssets(context,
        pickerConfig: AssetPickerConfig(
            textDelegate: const AssetPickerTextDelegate(),
            maxAssets: limit,
            requestType: RequestType.image));
    if (result != null) {
      var assets = Set<AssetEntity>.from(result);
      List<Entity> selectValues = [];
      for (var asset in assets) {
        File? file = await asset.file;

        if (file != null) {
          selectValues.add(Entity(DataUtil.genUid(), file.path, Entity.IMAGE));
        }
      }
      setState(() {
        if (_selectedEntities == null) {
          _selectedEntities = selectValues;
        } else {
          _selectedEntities!.addAll(selectValues);
        }
      });
    }
  }
}
