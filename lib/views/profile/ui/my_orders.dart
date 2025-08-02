import 'package:flutter/material.dart';
import 'package:e_commerce_app_using_supabase/core/components/products_list.dart';
import 'package:e_commerce_app_using_supabase/core/functions/build_appbar.dart';

class MyOrdersView extends StatelessWidget {
  const MyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, "My Orders"),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: ProductsList(
          shrinkWrap: false,
          physics: BouncingScrollPhysics(),
          isMyOrdersView: true,
        ),
      ),
    );
  }
}
