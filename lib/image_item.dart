import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:external_path/external_path.dart';

class ImageItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ImageState();
}

class _ImageState extends State<ImageItem> {
  File? _image;
  String? _path;
  String? contnet;
  List<String>? dirs = [];

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

  Future<void> _pickFile() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.any, allowMultiple: false);
    if (result != null) {
      setState(() {
        _image = File(result.files.single.path!);
        _path = result.files.single.path;
      });
    }
  }

  Future<void> _showDir() async {
    final status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
      var dir = await getExternalStorageDirectory();
      if (dir?.path != null) {
        setState(() {
          contnet = dir!.path;
        });
      }
    }
  }

  Future<void> _getDcimDirectory() async {
    // Directory dcimDirectory = await ExternalPath.getDcimDirectory();
    // String dcimPath = dcimDirectory.path;
    // print('DCIM directory path: $dcimPath');
    final status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
      final path = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DCIM);
      final dcimDirectory = Directory(path);
      List<String> temp = [];
      dcimDirectory.list().forEach((entity) {
        // print(entity.path);
        temp.add(entity.path);
      });
      setState(() {
        dirs = temp;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return testDir();
    // if (_path == null) {
    //   return Column(
    //     children: [
    //       ElevatedButton(onPressed: _pickFile, child: const Text("选择图片")),
    //       ElevatedButton(onPressed: _getDcimDirectory, child: const Text("显示目录"))
    //     ],
    //   );
    // } else {
    //   return Column(
    //     children: [
    //       // FileImage(_image),
    //       // Image.file(_image!),
    //       Text(_path!),
    //       Image.file(File.fromRawPath(utf8.encode(_path!))),
    //       Image.file(File.fromRawPath(utf8.encode(
    //           "/storage/emulated/0/DCIM/Camera/IMG_20240922_104229.jpg"))),
    //       Text(contnet ?? ""),
    //       ElevatedButton(onPressed: _pickFile, child: const Text("选择图片")),
    //       ElevatedButton(onPressed: _getDcimDirectory, child: const Text("显示目录")),
    //     ],
    //   );
    // }
  }

  Widget testDir(){
    if(dirs== null || dirs?.length == 0){
        return ElevatedButton(onPressed: _getDcimDirectory, child: const Text("显示目录"));
    }else {
      List<Widget> list = [];
      dirs!.forEach((file){
        if(FileSystemEntity.isFileSync(file)){
          list.add( Image.file(File.fromRawPath(utf8.encode(file))));
        }
      });
      return ListView(children: list,);
    }
  }
}
