import 'package:ecommerce_fash_app/components/products.dart';
import 'package:ecommerce_fash_app/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cart_screen.dart';

class ProductDetails extends StatefulWidget {
  final productTitle;
  final productImage;
  final productOldPrice;
  final productNewPrice;

  ProductDetails(
      {this.productTitle,
      this.productImage,
      this.productOldPrice,
      this.productNewPrice});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: Text('FashApp')),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ShoppingCart()));
          }, icon: const Icon(Icons.shopping_cart)),
        ],
      ),

      // Product Details
      body: ListView(
        children: [
          Container(
            height: 300.0,
            color: Colors.white,
            child: GridTile(
              child: Image.asset(widget.productImage),
            ),
          ),
          Container(
            color: Colors.grey,
            child: ListTile(
              leading: Text(
                widget.productTitle,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              title: Padding(
                padding: const EdgeInsets.fromLTRB(30, 8, 8, 8),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      '₹${widget.productNewPrice}',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )),
                    Expanded(
                        child: Text(
                      '₹${widget.productOldPrice}',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          decoration: TextDecoration.lineThrough),
                    )),
                  ],
                ),
              ),
            ),
          ),

          // Button Row
          Row(
            children: [
              Expanded(
                child: MaterialButton(
                  color: Colors.white,
                  textColor: Colors.grey,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Size'),
                            content: Text('Choose a size'),
                            actions: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: Text(
                                  'close',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                            // actionsAlignment: Alignment,
                          );
                        });
                  },
                  child: Row(
                    children: [
                      Expanded(child: Text('Size')),
                      Expanded(child: Icon(Icons.keyboard_arrow_down))
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 4.0,
              ),
              Expanded(
                child: MaterialButton(
                  color: Colors.white,
                  textColor: Colors.grey,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Color'),
                            content: Text('Choose a color'),
                            actions: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: Text(
                                  'close',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              )
                            ],
                          );
                        });
                  },
                  child: Row(
                    children: [
                      Expanded(child: Text('Color')),
                      Expanded(child: Icon(Icons.keyboard_arrow_down))
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 4.0,
              ),
              Expanded(
                child: MaterialButton(
                  color: Colors.white,
                  textColor: Colors.grey,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Quantity'),
                            content: Text('Choose a quantity'),
                            actions: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: Text(
                                  'close',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                            // actionsAlignment: Alignment,
                          );
                        });
                  },
                  child: Row(
                    children: [
                      Expanded(child: Text('Qty')),
                      Expanded(child: Icon(Icons.keyboard_arrow_down))
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Another Button Row
          Row(
            children: [
              Expanded(
                  child: MaterialButton(
                elevation: 0.2,
                onPressed: () {},
                color: Colors.red,
                textColor: Colors.white,
                child: Text('Buy Now'),
              )),
              SizedBox(
                width: 4.0,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add_shopping_cart,
                  color: Colors.deepOrange,
                ),
              ),
              SizedBox(
                width: 4.0,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                ),
              ),
            ],
          ),

          Divider(),

          // Product Description
          ListTile(
            title: Text('Description'),
            subtitle: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
          ),

          Divider(),

          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text(
                  'Product Name',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text('${widget.productTitle}'),
              ),
            ],
          ),

          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text(
                  'Brand Name',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text('Brand X'),
              ),
            ],
          ),

          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text(
                  'Product Condition',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text('NEW'),
              ),
            ],
          ),

          Divider(),

          Padding(
            padding: EdgeInsets.fromLTRB(15, 8, 0, 8),
            child: Text(
              'You may also like',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),

          // You may also like "ListView"
          Container(
            height: 220,
            child: ListView.builder(
                itemCount: productList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return SimilarProductTile(
                    title: productList[index]['title'],
                    image: productList[index]['image'],
                    oldPrice: productList[index]['oldPrice'],
                    newPrice: productList[index]['newPrice'],
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class SimilarProductTile extends StatelessWidget {
  final title;
  final image;
  final oldPrice;
  final newPrice;

  SimilarProductTile({this.title, this.image, this.oldPrice, this.newPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 200,
      color: Colors.white12,
      child: GridTile(
        child: Image.asset(
          image,
          fit: BoxFit.fitHeight,
        ),
        footer: Container(
          color: Colors.white54,
          child: ListTile(
            title: Text(title),
            subtitle: Row(
              children: [
                Expanded(
                    child: Text(
                      '₹${newPrice}',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )),
                Expanded(
                    child: Text(
                      '₹${oldPrice}',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// SimilarProductTile(
// title: productList[index]['title'],
// image: productList[index]['image'],
// oldPrice: productList[index]['oldPrice'],
// newPrice: productList[index]['newPrice'],
// )
