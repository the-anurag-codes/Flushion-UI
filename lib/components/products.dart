import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/product_details.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List productList = [
    {
      "title": "Blazer",
      "image": "assets/products/blazer1.jpeg",
      "oldPrice": 320,
      "newPrice": 250,
    },
    {
      "title": "Red Dress",
      "image": "assets/products/dress1.jpeg",
      "oldPrice": 400,
      "newPrice": 350,
    },
    {
      "title": "Black Dress",
      "image": "assets/products/dress2.jpeg",
      "oldPrice": 600,
      "newPrice": 350,
    },
    {
      "title": "Blue Skirt",
      "image": "assets/products/skt1.jpeg",
      "oldPrice": 450,
      "newPrice": 280,
    },
    {
      "title": "Casual Shoe",
      "image": "assets/products/shoe1.jpg",
      "oldPrice": 700,
      "newPrice": 550,
    },
    {
      "title": "Formal Pant",
      "image": "assets/products/pants1.jpg",
      "oldPrice": 400,
      "newPrice": 299,
    },
    {
      "title": "Red Heals",
      "image": "assets/products/hills2.jpeg",
      "oldPrice": 600,
      "newPrice": 489,
    },
    {
      "title": "Pink Skirt",
      "image": "assets/products/skt2.jpeg",
      "oldPrice": 350,
      "newPrice": 299,
    },
    {
      "title": "Brown Heals",
      "image": "assets/products/hills1.jpeg",
      "oldPrice": 399,
      "newPrice": 299,
    },
    {
      "title": "Casual Jean",
      "image": "assets/products/pants2.jpeg",
      "oldPrice": 599,
      "newPrice": 349,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: productList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return ProductTile(
            title: productList[index]['title'],
            image: productList[index]['image'],
            oldPrice: productList[index]['oldPrice'],
            newPrice: productList[index]['newPrice'],
          );
        });
  }
}

class ProductTile extends StatelessWidget {
  final title;
  final image;
  final oldPrice;
  final newPrice;

  ProductTile({this.title, this.image, this.oldPrice, this.newPrice});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: title,
          child: Material(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProductDetails(
                          productTitle: title,
                          productImage: image,
                          productOldPrice: oldPrice,
                          productNewPrice: newPrice,
                        )));
              },
              child: GridTile(
                footer: Container(
                  color: Colors.white70,
                  child: ListTile(
                    leading: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    title: Text('₹$newPrice',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w800)),
                    subtitle: Text(
                      '₹$oldPrice',
                      textAlign: TextAlign.center,
                      style: TextStyle(decoration: TextDecoration.lineThrough),
                    ),
                  ),
                ),
                child: Image.asset(image),
              ),
            ),
          )),
    );
  }
}
