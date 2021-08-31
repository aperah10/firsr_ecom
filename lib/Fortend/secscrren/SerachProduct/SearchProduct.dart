import 'package:first_ecom/Backend/Logic/Bloc/product/Product_Show/productshow_bloc.dart';
import 'package:first_ecom/Backend/Logic/Bloc/product/Search_Product/searchproduct_bloc.dart';
import 'package:first_ecom/Backend/Respo/Product/ProdRespo.dart';
import 'package:first_ecom/Fortend/secscrren/SingleProductDeltails/ProductDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'SearchWidget.dart';

class SearchProductPage extends StatefulWidget {
  SearchProductPage({Key? key}) : super(key: key);

  @override
  _SearchProductPageState createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  // ProductshowBloc prodBloc;
  ProductshowBloc prodBloc = ProductshowBloc(prodRespo: ProductDataRespo());

  @override
  void initState() {
    prodBloc = BlocProvider.of<ProductshowBloc>(context);
    prodBloc.add(FetchProductEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: SearchProduct(
                        searchBloc:
                            BlocProvider.of<SearchproductBloc>(context)));
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: BlocBuilder<ProductshowBloc, ProductshowState>(
              builder: (context, state) {
            if (state is ProductshowInitial) {
              return buildLoading();
            } else if (state is ProductLoadingState) {
              return buildLoading();
            } else if (state is ProductLoadedState) {
              return buildHintsList(state.productData);
            } else if (state is ProductErrorState) {
              return buildError(state.message);
            }
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }),
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                         // !SEARCH PRODUCT DELEGAGE                        */
/* -------------------------------------------------------------------------- */

class SearchProduct extends SearchDelegate<List> {
  SearchproductBloc searchBloc;

  SearchProduct({required this.searchBloc});
  late String queryString;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    queryString = query;
    searchBloc.add(SearchProd(query: query));
    return BlocBuilder<SearchproductBloc, SearchproductState>(
      builder: (BuildContext context, SearchproductState state) {
        if (state is SearchproductInitial) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is SearachErrorState) {
          return Center(
            child: Text('Failed To Load'),
          );
        }
        if (state is SearchLoadedState) {
          if (state.productData.isEmpty) {
            return Center(
              child: Text('No Results'),
            );
          }
          return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  // ! SINGLE PAGE LINK
                                  ItemDetailsScreen(
                                    prod: state.productData[index],
                                  )));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 90,
                            width: 100,
                            child: Image.network(
                                state.productData[index].pic ?? '')),
                        Text(state.productData[index].title ?? ''),
                      ],
                    ),
                  ),
                );

                //Text(state.recipes[index].title);
              },
              itemCount: state.productData.length);
        }
        return Scaffold();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
