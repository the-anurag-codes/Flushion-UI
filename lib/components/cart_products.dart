import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartProducts extends StatefulWidget {
  const CartProducts({Key? key}) : super(key: key);

  @override
  State<CartProducts> createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  List productsInTheCart = [
    {
      "title": "Blazer",
      "image": "assets/products/blazer1.jpeg",
      "newPrice": 250,
      "size": "M",
      "color": "Black",
      "quantity": 1,
    },
    {
      "title": "Red Dress",
      "image": "assets/products/dress1.jpeg",
      "newPrice": 350,
      "size": "L",
      "color": "Red",
      "quantity": 1,
    },
    {
      "title": "Formal Pant",
      "image": "assets/products/pants1.jpg",
      "newPrice": 299,
      "size": "L",
      "color": "Grey",
      "quantity": 1,
    },
    {
      "title": "Red Heals",
      "image": "assets/products/hills2.jpeg",
      "newPrice": 489,
      "size": "7",
      "color": "Red",
      "quantity": 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: productsInTheCart.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              CartTile(
                title: productsInTheCart[index]['title'],
                image: productsInTheCart[index]['image'],
                price: productsInTheCart[index]['newPrice'],
                size: productsInTheCart[index]['size'],
                color: productsInTheCart[index]['color'],
                quantity: productsInTheCart[index]['quantity'],
              ),
              Divider(),
            ],
          );
        });
  }
}

class CartTile extends StatelessWidget {
  final title;
  final image;
  final price;
  final size;
  final color;
  final quantity;

  CartTile(
      {this.title,
      this.price,
      this.image,
      this.size,
      this.color,
      this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: Colors.white),
      child: Row(
        children: [
          // PRODUCT IMAGE
          Expanded(
              child: Image.asset(
            image,
            height: 180,
            width: 180,
          )),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // PRODUCT NAME
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 4.0, 4.0),
                  child: Text(
                    '$title',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
                  ),
                ),

                // PRODUCT PRICE
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 4.0, 4.0, 4.0),
                  child: Text(
                    '₹${price}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                // PRODUCT SIZE
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 4.0, 4.0, 4.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 4.0, 8.0, 0),
                        child: Text(
                          'Size:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0),
                        child: Text(size),
                      ),
                    ],
                  ),
                ),

                // PRODUCT COLOR
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 4.0, 4.0, 4.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 4.0, 8.0, 0),
                        child: Text(
                          'Color:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0),
                        child: Text(color),
                      ),
                    ],
                  ),
                ),

                // DELETE BUTTON
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 4.0, 4.0, 4.0),
                  child: MaterialButton(
                    onPressed: () {},
                    child: Text('Delete'),
                    color: Colors.white,
                    textColor: Colors.black,
                    highlightColor: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // QUANTITY OF THE PRODUCT
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    alignment: Alignment.center,
                    width: 30,
                    height: 30,
                    color: Colors.grey,
                    child: Icon(Icons.add)),
                Container(
                    height: 30,
                    alignment: Alignment.center,
                    width: 30,
                    child: Text(
                      '$quantity',
                      style: TextStyle(fontSize: 16.0),
                    )),
                Container(
                    alignment: Alignment.center,
                    width: 30,
                    height: 30,
                    color: Colors.grey,
                    child: Icon(Icons.remove))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
