import 'package:ecommerce_fash_app/screens/cart_screen.dart';
import 'package:ecommerce_fash_app/screens/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce_fash_app/screens/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_fash_app/components/carousel.dart';

import '../components/categories.dart';
import '../components/products.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('FashApp'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ShoppingCart()));
              },
              icon: const Icon(Icons.shopping_cart)),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: UserDetails().userName.toString() == ''
                  ? Text(UserDetails().userName.toString())
                  : Text('User'),
              accountEmail: UserDetails().email.toString() == ''
                  ? Text(UserDetails().email.toString())
                  : Text('User@gmail.com'),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.redAccent,
                ),
                title: Text('Home'),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.redAccent,
                ),
                title: Text('My Account'),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                leading: Icon(
                  Icons.shopping_basket,
                  color: Colors.redAccent,
                ),
                title: Text('My Orders'),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                leading: Icon(
                  Icons.dashboard,
                  color: Colors.redAccent,
                ),
                title: Text('Categories'),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                leading: Icon(
                  Icons.favorite,
                  color: Colors.redAccent,
                ),
                title: Text('Favorites'),
              ),
            ),
            Divider(
              thickness: 1.0,
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.blueGrey,
                ),
                title: Text('Setting'),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                leading: Icon(
                  Icons.help,
                  color: Colors.blue,
                ),
                title: Text('About'),
              ),
            ),
            InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                });
              },
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.red.shade900,
                ),
                title: Text('Logout'),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Carousel
          ImageCarousel(),

          // Padding
          Padding(
            padding: EdgeInsets.fromLTRB(15, 8, 0, 4),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ),
          ),

          // Categories
          Categories(),

          // Padding
          Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 0, 10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent Products',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ),
          ),

          // Recent Products
          Flexible(child: Products()),
        ],
      ),
    );
  }
}
