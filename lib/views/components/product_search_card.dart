import 'package:flutter/material.dart';

import '../../constants.dart';
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
      leading: Image.network(
        "$kHostIP/${Uri.encodeComponent(product.images[0].path)}",
      ),
      onTap: () {
        //
      },
    );
  }
}
