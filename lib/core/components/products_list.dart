import 'package:e_commerce_app_using_supabase/core/components/custom_circle_pro_ind.dart';
import 'package:e_commerce_app_using_supabase/core/cubit/home_cubit.dart';
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
  });

  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  final String? searchQuery;
  final String? category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit()..getProducts(query: searchQuery, category: category),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          List<ProductModel> products = searchQuery != null
              ? context.read<HomeCubit>().searchResults
              : category != null
              ? context.read<HomeCubit>().categoryResults
              : context.read<HomeCubit>().products;
          HomeCubit homeCubit = context.read<HomeCubit>();
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
