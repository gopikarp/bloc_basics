import 'package:akshit_bloc/features/home/bloc/home_bloc.dart';
import 'package:akshit_bloc/features/home/model/home_product_data.dart';
import 'package:flutter/material.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel ProductDataModels;
  final HomeBloc homeBloc;
  const ProductTileWidget(
      {super.key, required this.ProductDataModels, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(ProductDataModels.imageUrl))),
          ),
          const SizedBox(height: 20),
          Text(ProductDataModels.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(ProductDataModels.description),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("\$" + ProductDataModels.price.toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeProductWishlistButtonClickedEvent(
                            clickedProduct: ProductDataModels));
                      },
                      icon: Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeProductCartButtonClickedEvent(
                            clickedProduct: ProductDataModels));
                      },
                      icon: Icon(Icons.shopping_bag_outlined)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
