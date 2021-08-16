import 'package:flutter/material.dart';
import 'package:image_slider/image_slider.dart';

Widget sliderImage(TabController tabController,BuildContext context,List<Widget> children)
{
  return ImageSlider(
    /// Shows the tab indicating circles at the bottom
    showTabIndicator: false,

    /// Cutomize tab's colors
    tabIndicatorColor: Colors.lightBlue.shade300,

    /// Customize selected tab's colors
    tabIndicatorSelectedColor: Colors.lightBlue.shade800,

    /// Height of the indicators from the bottom
    tabIndicatorHeight: 9,

    /// Size of the tab indicator circles
    tabIndicatorSize: 9,

    /// tabController for walkthrough or other implementations
    tabController: tabController,

    /// Animation curves of sliding
    curve: Curves.fastOutSlowIn,

    /// Width of the slider
    width: MediaQuery.of(context).size.width,

    /// Height of the slider
    height: 220,

    /// If automatic sliding is required
    autoSlide: true,

    /// Time for automatic sliding
    duration: new Duration(seconds: 3),

    /// If manual sliding is required
    allowManualSlide: true,

    /// Children in slideView to slide
    children: children,
  );
}