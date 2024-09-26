import 'package:flutter/material.dart';
import 'package:flutter_learn/card.dart';
import 'package:flutter_learn/image_item.dart';
import 'package:flutter_learn/model/classify_value.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(
          title: 'Flutter Demo Home Page',
          values: List<ClassifyValue>.generate(
              4,
              (i) => ClassifyValue("广州游记", "images/test.jpg",
                  "2024年9月的一个周末，我门去广州游玩😊😄😄\n 广州市🗺️，简称“穗”，别称羊城、花城、五羊城，广东省辖地级市🚩，是广东省省会、副省级市、国家中心城市、超大城市 [272]，地处中国华南地区，广东省中南部，珠江三角洲的北缘，接近珠江流域下游入海口，总面积7434.40平方千米。 [452]截至2023年10月，广州市下辖11个区。 [1] [69]截至2023年末，广州市常住人口1882.70万人"))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.values});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  final List<ClassifyValue> values;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
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
      // appBar: AppBar(
      //   // TRY THIS: Try changing the color here to a specific color (to
      //   // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
      //   // change color while the other colors stay the same.
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),

      body: Center(child: ImageItem()),
      
      // body:  ListView.builder(
      //     itemCount: widget.values.length,
      //     itemBuilder: (context, index) {
      //       return Center(child: CardItem(classifyValue: widget.values[index])) ;
      //     }),



      // body: CardItem(classifyValue: ClassifyValue("广州游记", "images/test.jpg",
      //             "2024年9月的一个周末，我门去广州游玩😊😄😄\n 广州市🗺️，简称“穗”，别称羊城、花城、五羊城，广东省辖地级市🚩，是广东省省会、副省级市、国家中心城市、超大城市 [272]，地处中国华南地区，广东省中南部，珠江三角洲的北缘，接近珠江流域下游入海口，总面积7434.40平方千米。 [452]截至2023年10月，广州市下辖11个区。 [1] [69]截至2023年末，广州市常住人口1882.70万人")),
      // body: Center(
      //   // Center is a layout widget. It takes a single child and positions it
      //   // in the middle of the parent.
      //   child: Column(
      //     // Column is also a layout widget. It takes a list of children and
      //     // arranges them vertically. By default, it sizes itself to fit its
      //     // children horizontally, and tries to be as tall as its parent.
      //     //
      //     // Column has various properties to control how it sizes itself and
      //     // how it positions its children. Here we use mainAxisAlignment to
      //     // center the children vertically; the main axis here is the vertical
      //     // axis because Columns are vertical (the cross axis would be
      //     // horizontal).
      //     //
      //     // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
      //     // action in the IDE, or press "p" in the console), to see the
      //     // wireframe for each widget.
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     // children: <Widget>[
      //     //   const Text(
      //     //     'You have pushed the button this many times:',
      //     //   ),
      //     //   Text(
      //     //     '$_counter',
      //     //     style: Theme.of(context).textTheme.headlineMedium,
      //     //   ),
      //     // ],
      //     children: [CardItem(classifyValue: ClassifyValue("广州游记", "images/test.jpg","2024年9月的一个周末，我门去广州游玩😊😄😄\n 广州市🗺️，简称“穗”，别称羊城、花城、五羊城，广东省辖地级市🚩，是广东省省会、副省级市、国家中心城市、超大城市 [272]，地处中国华南地区，广东省中南部，珠江三角洲的北缘，接近珠江流域下游入海口，总面积7434.40平方千米。 [452]截至2023年10月，广州市下辖11个区。 [1] [69]截至2023年末，广州市常住人口1882.70万人"))],
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
