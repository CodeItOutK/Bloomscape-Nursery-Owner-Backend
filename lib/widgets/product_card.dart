import 'package:bloomscape_backend/bloc/blocs.dart';
import 'package:bloomscape_backend/widgets/custom_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/category_model.dart';
import '../model/product_model.dart';
import 'custom_dropdown_button.dart';
class ProductCard extends StatelessWidget {
  const ProductCard({Key? key,required this.product,}) : super(key: key);

  final Product product;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 10),

      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(radius: 40,backgroundImage: AssetImage(product.imageUrl),),
          Text(product.name,style: Theme.of(context).textTheme.headline5,),
          Text("Rs ${product.price}",style: Theme.of(context).textTheme.headline6,)
        ],
      )
    );
  }
}


