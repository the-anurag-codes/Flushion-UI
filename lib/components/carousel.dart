import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({Key? key}) : super(key: key);

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _current = 0;
  List<String> imgList = [
    'assets/m1.jpeg',
    'assets/c1.jpg',
    'assets/m2.jpg',
    'assets/w1.jpeg',
    'assets/w3.jpeg',
    'assets/w4.jpeg',
  ];

  List<T> map<T>(List list, Function handler){
    List<T> result = [];
    for (var i = 0; i < list.length; i++){
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CarouselSlider(
            items: imgList.map((e) {
              return Builder(builder: (BuildContext context){
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Image.asset(e, fit: BoxFit.cover,),
                );
              });
            }).toList(),
            options: CarouselOptions(
                autoPlay: false,
                initialPage: 0,
                height: 230.0,
                enlargeCenterPage: true,
                pauseAutoPlayOnTouch: true,
                aspectRatio: 16/8,
                onPageChanged: (index, reason){
                  setState(() {
                    _current = index;
                  });
                }
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(
                imgList, (index, path){
              return Container(
                width: 10.0,
                height: 10.0,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index ? Colors.redAccent : Colors.grey,
                ),
              );
            }
            ),
          )
        ],
      ),
    );
  }
}
