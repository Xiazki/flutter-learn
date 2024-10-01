import 'package:flutter/material.dart';
import 'package:flutter_learn/model/entity.dart';

class ImageView extends StatefulWidget {
  final Entity source;
  final String title;

  ImageView(this.source, this.title);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  late String _title;
  @override
  void initState() {
    super.initState();
    print('initState: ${widget.source.id}');
    _title = widget.title;
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose: ${widget.source.id}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Container(
              alignment: Alignment.center,
              child: Hero(
                tag: widget.source.id,
                child: Image(
                  image: AssetImage(widget.source.url),
                  fit: BoxFit.contain,
                ),
              ),
            )),
            Container(
              height: 50,
              // color: Colors.white.withOpacity(0.3),
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  _title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
