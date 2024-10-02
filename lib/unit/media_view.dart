import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/model/entity.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

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
    _title = widget.title;
  }

  @override
  void dispose() {
    super.dispose();
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

class VideoView extends StatefulWidget {
  final Entity source;
  final bool? isFocus;

  VideoView(this.source, {this.isFocus});

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  VideoPlayerController? _controller;
  late VoidCallback listener;
  String? localFileName;

  _VideoViewState() {
    listener = () {
      if (!mounted) {
        return;
      }
      setState(() {});
    };
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    _controller = VideoPlayerController.asset(widget.source.url);
    // loop play
    _controller!.setLooping(true);
    await _controller!.initialize();
    setState(() {});
    _controller!.addListener(listener);
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose: ${widget.source.id}');
    _controller!.removeListener(listener);
    _controller?.pause();
    _controller?.dispose();
  }

  @override
  void didUpdateWidget(covariant VideoView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isFocus! && !widget.isFocus!) {
      // pause
      _controller?.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _controller!.value.isInitialized
        ? Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _controller!.value.isPlaying
                        ? _controller!.pause()
                        : _controller!.play();
                  });
                },
                child: Hero(
                  tag: widget.source.id,
                  child: AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: VideoPlayer(_controller!),
                  ),
                ),
              ),
              _controller!.value.isPlaying == true
                  ? const SizedBox()
                  : const IgnorePointer(
                      ignoring: true,
                      child: Icon(
                        Icons.play_arrow,
                        size: 100,
                        color: Colors.white,
                      ),
                    ),
            ],
          )
        : Theme(
            data: ThemeData(
                cupertinoOverrideTheme:
                    const CupertinoThemeData(brightness: Brightness.dark)),
            child: const CupertinoActivityIndicator(radius: 30));
  }
}

class FlickVideoView extends StatefulWidget {
  Entity entity;
  FlickVideoView({super.key, required this.entity});

  @override
  _FlickVideoViewState createState() => _FlickVideoViewState();
}

class _FlickVideoViewState extends State<FlickVideoView> {
  late FlickManager flickManager;
  late VideoPlayerController videoPlayerController;
  late double width;
  late double height = 1024;
  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.asset(widget.entity.videUrl!);
    videoPlayerController.initialize().then((_) {
      // 获取视频的宽高比
      setState(() {
        // width = videoPlayerController.value.size.width;
        // height = videoPlayerController.value.size.height;
      });

      // final videoAspectRatio = videoWidth / videoHeight;
    });

    flickManager = FlickManager(
      videoPlayerController: videoPlayerController,
    );
  }

  @override
  void dispose() {
    flickManager.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickManager),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction == 0 && this.mounted) {
          flickManager.flickControlManager?.autoPause();
        } else if (visibility.visibleFraction == 1) {
          flickManager.flickControlManager?.autoResume();
        }
      },
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: PopScope(
              onPopInvokedWithResult: (didPop, result) => {
                if (flickManager.flickControlManager != null &&
                    flickManager.flickControlManager!.isFullscreen)
                  {flickManager.flickControlManager!.exitFullscreen()}
              },
              child: Container(
                alignment: Alignment.center,
                child: FlickVideoPlayer(
                  flickManager: flickManager,
                  flickVideoWithControls: const FlickVideoWithControls(
                    videoFit: BoxFit.contain,
                    closedCaptionTextStyle: TextStyle(fontSize: 8),
                    controls: FlickPortraitControls(),
                  ),
                  flickVideoWithControlsFullscreen:
                      const FlickVideoWithControls(
                    controls: FlickLandscapeControls(),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
