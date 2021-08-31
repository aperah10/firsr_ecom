import 'package:first_ecom/Fortend/Widget/AppBarWid.dart';
import 'package:first_ecom/Fortend/Widget/Form/formWidget.dart';
import 'package:first_ecom/Fortend/Widget/Grid_List_prod.dart/GridWidget.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart-screens';
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  // final dl = List.generate(15, (index) => CatModel.items);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titlename: 'Cart'),
      body: new Container(
          child: Stack(
        children: <Widget>[
          ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                print(index);
                // return dataOfListView(product: CatModel.items[index]);
                return ListdataScreen(product: CatModel.items[index]);
                
              }),

          // SUBMIT BUTTON TO
          Align(
              alignment: Alignment.bottomCenter,
              child: BtnC(
                btnname: 'Continue',
              ))
        ],
      )),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                            // ! CART LIST SCREEN                           */
/* -------------------------------------------------------------------------- */


class ListdataScreen extends StatelessWidget {
  dynamic product;
  var iconname;
  ListdataScreen({Key? key, this.product , this.iconname}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
      color: Color(0xffEEEEEE),
      child: ListTile(
        // on ListItem clicked
        onTap: () {},

        // Image of ListItem
        leading: Container(
          child: Image(
            fit: BoxFit.fitHeight,
            image: AssetImage(product.picurl),
          ),
        ),

        // Lists of titles
        title: Container(
          margin: EdgeInsets.only(top: 10.0),
          height: 80.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(bottom: 2.0),
                  child: Text(
                    product.name,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  )),
              Container(
                padding: EdgeInsets.only(bottom: 3.0),
                child: Text(
                  "Item Cetegory",
                  style: TextStyle(),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 3.0),
                child: Text(
                  product.price.toString(),
                  style: TextStyle(color: Color(0xff374ABE)),
                ),
              ),
            ],
          ),
        ),

        // Item Add and Remove Container
        subtitle: Container(
            child: Wrap(
          direction: Axis.horizontal,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                print(product.id);
              },
              child: Icon(
                Icons.remove,
                size: 19.0,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, top: 1.0, right: 10.0),
              child: Text(
                product.id.toString(),
                style: TextStyle(color: Colors.black),
              ),
            ),

            // Add count button
            GestureDetector(
              onTap: () {
                // itemCount++;
              },
              child:iconCond(iconname: 'add')
              //  Icon(
              //   Icons.add,
              //   size: 19.0,
              // ),
            ),
          ],
        )),

        // trailing shows the widget on the right corner of the list item
        trailing: iconCond(iconname: iconname),
      ),
    ));
  }
}

// Widget Conditon check
Widget iconCond({var iconname}) {
  Widget child;

  switch (iconname) {
    case 'refresh':
      child = Icon(
        Icons.refresh,
        size: 30,
        color: Color(0xff374ABE),
      );
      break;
    case 'add':
      child = Icon(
        Icons.add,
        size: 20,
        color: Color(0xff374ABE),
      );
      break;
    default:child = Icon(
        Icons.cancel,
        size: 30,
        color: Color(0xff374ABE),
      );
     
  }

  // Finally returning a Widget
  return Container(child: child);
}
