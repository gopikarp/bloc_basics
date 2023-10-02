import 'package:akshit_bloc/features/cart/ui/cart_page.dart';
import 'package:akshit_bloc/features/home/bloc/home_bloc.dart';
import 'package:akshit_bloc/features/home/ui/product_tile_widget.dart';
import 'package:akshit_bloc/features/wish/wish.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CartPage(),
            ),
          );
        }
        if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WishList(),
            ),
          );
        }
        if (state is HomeProductItemWishlistedActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('wish addedd')));
        }
      },
      builder: (context, State) {
        switch (State.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );

          case HomeLoadedSuccessState:
            final successState = State as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.shopping_cart_outlined)),
                ],
              ),
              body: ListView.builder(
                itemBuilder: (context, index) => ProductTileWidget(
                    homeBloc: homeBloc,
                    ProductDataModels: successState.product[index]),
                itemCount: successState.product.length,
              ),
            );
          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Text("error"),
              ),
            );

          default:
            return const SizedBox();
        }
      },
    );
  }
}
