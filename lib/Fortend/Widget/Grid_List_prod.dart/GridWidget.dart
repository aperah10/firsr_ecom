import 'package:flutter/material.dart';

class GridViewWidget extends StatelessWidget {
  GridViewWidget({Key? key, this.productstate}) : super(key: key);

  dynamic productstate;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
          shrinkWrap: true,
          itemCount: productstate.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.60,
            // crossAxisSpacing: 20,
            //   mainAxisSpacing: 20
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          itemBuilder: (context, index) {
            return ListViewBuilderShow(product: productstate[index]);
          }),
    );
  }
}

// ========================== LIST VIEW BUILDER FOR EVERYONE PAGE ===============================

class ListViewBuilderShow extends StatelessWidget {
  ListViewBuilderShow({Key? key, this.product}) : super(key: key);

  dynamic product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: SizedBox(
        width: 160.0,
        child: Wrap(
          children: <Widget>[
            Image.asset(product.pic == null ? '' : product.pic),
            ListTile(
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => ItemDetailsScreen()));
              },
              title: Text(
                product.title,
                // title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                product.description,
                // subTitle,
                style: TextStyle(fontSize: 12.0),
              ),
            ),
            Row(
              children: [
                btnC(btnname: 'buynow'),
                btnC(btnname: 'addtocart'),
              ],
            )
          ],
        ),
      ),
    );
  }

  // buttons for product
  Expanded btnC({required String btnname}) {
    return Expanded(
        child: InkWell(
            onTap: () {},
            child: Container(
                // height: 40, width: 50,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.redAccent, Colors.red],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                    ),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Center(
                    child: Text(btnname,
                        style: TextStyle(color: Colors.white))))));
  }
}
