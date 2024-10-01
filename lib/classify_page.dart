import 'package:flutter/material.dart';
import 'package:flutter_learn/add/classify_add_page.dart';
import 'package:flutter_learn/card.dart';
import 'package:flutter_learn/model/classify_value.dart';
import 'package:flutter_learn/util/data_util.dart';

class ClassifyPage extends StatefulWidget {
  const ClassifyPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  // final List<ClassifyValue> values;

  @override
  State<ClassifyPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ClassifyPage> {
  final String title = "相册集";

  late List<ClassifyValue> values;
  int _counter = 0;
  String _atitle = "相册集";

  @override
  void initState() {
    values = DataUtil.listTemp();
  }

  void _incrementCounter() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ClassifyAddPage()));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(_atitle),
        // backgroundColor: Colors.white.withOpacity(0.3),
      ),
      body: ListView.builder(
          itemCount: values.length,
          itemBuilder: (context, index) {
            return Center(child: CardItem(classifyValue: values[index]));
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
          elevation: 10,
          onPressed: _incrementCounter,
          tooltip: '创建相册',
          shape: const CircleBorder(),
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          child: const Icon(
            Icons.add_to_photos_rounded,
            color: Colors.green,
          )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
