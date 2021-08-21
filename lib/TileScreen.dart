import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants/constants.dart';

class TileScreen extends StatefulWidget {
  @override
  _TileScreenState createState() => _TileScreenState();
}

class _TileScreenState extends State<TileScreen> {
  var data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Hero(
            tag: 'target${data[0]}',
            child: Image.asset(
              data[1],
              fit: BoxFit.cover,
              width: size.width,
              height: size.height,
            ),
          ),
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.9)],
                    stops: const [0.3, 0.9]),
               // borderRadius: BorderRadius.circular(12),
            ),
          ),
          Positioned(
            top: 32,
            right: 25,
            child: Row(
              children: List.generate(
                int.parse(data[4]),
                (index) => Icon(Icons.star,color: Colors.amber,),
              ),
            ),
          ),
          Positioned(
            top: 32,
            left: 18,
            child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 32,
                )),
          ),
          Positioned(
            bottom: 15,
            left: 20,
            child: Container(
                width: size.width / 1.1,
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  data[3],
                  textAlign: TextAlign.center,
                  style: xdBeyaz,
                )),
          )
        ]),
      ),
    );
  }
}
