import 'package:adana/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slide_drawer/slide_drawer.dart';
import 'package:video_player/video_player.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  VideoPlayerController? _controller;
  void initState() {
    super.initState();
    // Pointing the video controller to our local asset.
    _controller = VideoPlayerController.asset("assets/video/dd.mp4")
      ..initialize().then((_) {
        // Once the video has been loaded we play the video and set looping to true.
        _controller!.play();
        _controller!.setLooping(true);
        // Ensure the first frame is shown after the video is initialized.
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: sinir,
          centerTitle: true,
          title: Text(
            "DİYAR DİYAR ADANA",
          ),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: ()
            {
              SlideDrawer.of(context)!.toggle();
            },
          ),
        ),

        body: Stack(
          children: [
            SizedBox.expand(

              child: FittedBox(

                fit: BoxFit.fill,

                child: SizedBox(
                  width: _controller!.value.size.width,
                  height: _controller!.value.size.height,
                  child: VideoPlayer(_controller!),
                ),
              ),
            )
          ],
        )
      ),
    );
  }

}
