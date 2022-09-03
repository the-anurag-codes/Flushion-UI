import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          CategoriesType(imgPath: 'assets/cats/tshirt.png', caption: 'Shirt'),
          CategoriesType(imgPath: 'assets/cats/dress.png', caption: 'Dress'),
          CategoriesType(imgPath: 'assets/cats/formal.png', caption: 'Formal'),
          CategoriesType(imgPath: 'assets/cats/informal.png', caption: 'Informal'),
          CategoriesType(imgPath: 'assets/cats/jeans.png', caption: 'Jeans'),
          CategoriesType(imgPath: 'assets/cats/shoe.png', caption: 'Shoe'),
          CategoriesType(imgPath: 'assets/cats/accessories.png', caption: 'Accessories'),
        ],
      ),
    );
  }
}

class CategoriesType extends StatelessWidget {
  final String imgPath;
  final String caption;

  CategoriesType({required this.imgPath, required this.caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: (){},
        child: Container(
          width: 100.0,
          child: ListTile(
            title: Image.asset(imgPath, width: 100.0, height: 80.0,),
            subtitle: Text(caption, textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontSize: 15.0),),
          ),
        ),
      ),
    );
  }
}
