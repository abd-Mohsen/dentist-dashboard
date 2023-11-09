import 'package:cached_network_image/cached_network_image.dart';
import 'package:dentist_dashboard/views/products/product_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import '../../controllers/product_controller.dart';
import '../../models/product_model.dart';

class ProductSearchCard extends StatelessWidget {
  const ProductSearchCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    return ListTile(
      title: Text(
        product.title,
        style: tt.titleMedium!.copyWith(color: cs.onSurface),
      ),
      leading: CachedNetworkImage(
        //height: 50,
        width: 50,
        imageUrl: "$kHostIP/${Uri.encodeComponent(product.images[0].path)}",
        placeholder: (context, s) => Center(child: CircularProgressIndicator()),
      ),
      onTap: () {
        Get.put(ProductController());
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => ProductView(product: product),
        );
      },
    );
  }
}
