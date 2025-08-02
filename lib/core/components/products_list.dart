import 'package:e_commerce_app_using_supabase/core/components/custom_circle_pro_ind.dart';
import 'package:e_commerce_app_using_supabase/core/cubit/home_cubit.dart';
import 'package:e_commerce_app_using_supabase/core/functions/show_message.dart';
import 'package:e_commerce_app_using_supabase/core/models/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app_using_supabase/core/components/product_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({
    super.key,
    this.shrinkWrap,
    this.physics,
    this.searchQuery,
    this.category,
    this.isFavoriteView = false,
    this.isMyOrdersView = false,
  });

  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  final String? searchQuery;
  final String? category;
  final bool isFavoriteView;
  final bool isMyOrdersView;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit()..getProducts(query: searchQuery, category: category),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is BuyProductDone) {
            showMessage(context, "Payment Success :) :) :) :) :) :) :)");
          }
        },
        builder: (context, state) {
          HomeCubit homeCubit = context.read<HomeCubit>();
          List<ProductModel> products = searchQuery != null
              ? homeCubit.searchResults
              : category != null
              ? homeCubit.categoryResults
              : isFavoriteView
              ? homeCubit.favoriteProductList
              : isMyOrdersView
              ? homeCubit.userOrders
              : homeCubit.products;

          return state is GetDataLoading
              ? CustomCircleProgIndicator()
              : ListView.builder(
                  shrinkWrap: shrinkWrap ?? true,
                  physics: physics ?? const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    bool isFav = homeCubit.checkIfFavorite(
                      products[index].productId!,
                    );
                    return ProductCard(
                      onPaymentSuccess: () async {
                        await homeCubit
                            .buyProduct(productId: products[index].productId!)
                            .then((value) {});
                      },
                      isFavorite: isFav,
                      product: products[index],
                      onFavoritePressed: () {
                        isFav
                            ? homeCubit.removeFromFavorites(
                                products[index].productId!,
                              )
                            : homeCubit.addToFavorites(
                                products[index].productId!,
                              );
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}
