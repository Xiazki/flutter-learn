import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ImageState();
}

class _ImageState extends State<ImageItem> {
  File? _image;
  String? _path;
  String? contnet;

  void _selectImage(String path) {
    try {
      // 使用原始路径创建 File 对象
      final file = File.fromRawPath(utf8.encode(path));
      // 检查文件是否存在
      if (file.existsSync()) {
        setState(() {
          _image = file;
        });
      } else {
        print('文件不存在');
      }
    } catch (e) {
      print('无法创建 File 对象: $e');
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _path = pickedFile.path;
      });
    }
  }

  Future<void> _showDir() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      var dir = await getExternalStorageDirectory();
      // String c = "";
      dir?.list(recursive: true).forEach((entity) {
        setState(() {
          contnet = entity.path;
        });
        // c = "$c${entity.path}\n";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (contnet != null && contnet!="") {
      return Column(
        children: [
          Text(contnet ?? ""),
          ElevatedButton(onPressed: _showDir, child: const Text("显示目录"))
        ],
      );
    }
    if (_image == null) {
      return Column(
        children: [
          Text(contnet ?? ""),
          ElevatedButton(onPressed: _pickImage, child: const Text("选择图片")),
          ElevatedButton(onPressed: _showDir, child: const Text("显示目录"))
        ],
      );
    } else {
      return Column(
        children: [
          // FileImage(_image),
          Image.file(_image!),
          Text(_path!),
          Image.file(File.fromRawPath(utf8.encode(_path!))),
          Text(contnet ?? ""),
          ElevatedButton(onPressed: _pickImage, child: const Text("选择图片")),
          ElevatedButton(onPressed: _showDir, child: const Text("显示目录"))
        ],
      );
    }
  }
}
