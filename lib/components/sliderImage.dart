import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

Widget sliderImage(BuildContext context,List<String> links,)
{

  Size size = MediaQuery.of(context).size;

  return Container(
    width: size.width,
    child: CarouselSlider(
      options: CarouselOptions(),
      items: links
          .map((item) => Container(
        child: Center(
            child: Image.network(item,
              fit: BoxFit.cover,
              width: 1000,height: size.height/3,)),
      ))
          .toList(),
    ),
  );
}