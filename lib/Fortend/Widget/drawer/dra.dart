import 'package:first_ecom/Fortend/secscrren/Product_Scr/GridViewList.dart';
import 'package:first_ecom/Fortend/secscrren/Product_Scr/ListView.dart';
import 'package:first_ecom/Fortend/secscrren/Product_Scr/MixProductList.dart';
import 'package:first_ecom/Fortend/secscrren/SerachProduct/SearchProduct.dart';
import 'package:flutter/material.dart';

class MyDrawerList extends StatefulWidget {
  const MyDrawerList({Key? key}) : super(key: key);

  @override
  _MyDrawerListState createState() => _MyDrawerListState();
}

class _MyDrawerListState extends State<MyDrawerList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        _createDrawerHeader(),
        // top  level widgets
        itemList(context, () => ProductListView(),
            title: ' List Product', icon: Icons.pages_outlined),
        itemList(context, () => ProductGridView(),
            title: ' GridView ', icon: Icons.pages_outlined),
        itemList(context, () => SearchProductPage(),
            title: ' Search Product', icon: Icons.pages_outlined),
      ])),
    );
  }

  Widget itemList(
    BuildContext context,
    Widget Function() createPage, {
    required String title,
    required IconData icon,
  }) {
    return InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return createPage();
          }));
        },
        child: ListTile(
          title: Text(title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          leading: Icon(icon),
        ));
  }

  Widget _createDrawerHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        child: Stack(children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Image.asset(
                'images/app_logo.png',
                width: 130,
                height: 130,
              ),
            ),
          ),
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Rahul",
                  style: TextStyle(
                      color: Color(0xFF545454),
                      fontSize: 10.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }
}
