import 'package:flutter/material.dart';

import '../model/category_model.dart';
import '../model/product_model.dart';
class ProductListTile extends StatelessWidget {
  const ProductListTile({Key? key,required this.product,required this.onTap}) : super(key: key);

  final Product product;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading:CircleAvatar(backgroundImage: AssetImage(product.imageUrl),) ,
      title: Text(product.name,style: Theme.of(context).textTheme.headline5,),
      subtitle: Text(product.description,style: Theme.of(context).textTheme.headline6,),
      // trailing: const Icon(Icons.menu),
    );;
  }
}
