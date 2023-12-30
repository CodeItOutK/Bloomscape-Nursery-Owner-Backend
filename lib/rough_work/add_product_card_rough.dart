import 'package:bloomscape_backend/bloc/blocs.dart';
import 'package:bloomscape_backend/widgets/custom_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/category_model.dart';
import '../model/product_model.dart';
import '../widgets/custom_dropdown_button.dart';
class AddProductCard extends StatelessWidget {
  const AddProductCard ({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        margin: EdgeInsets.only(right: 10),

        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: (){
                  showDialog(context: context, builder:(BuildContext context){

                    return _buildNewProduct(context);
                  });
                },
                iconSize: 40, icon: Icon(Icons.add_circle,color: Theme.of(context).primaryColor,)),
            Text("Add a product",style: Theme.of(context).textTheme.headline5,),
          ],
        )

    );
  }

  Dialog _buildNewProduct(BuildContext context){
    Product product = const Product(

        name: '',
        category: '',
        description: '',
        imageUrl: '',
        price: 0);

    return Dialog(
      child: Container(height: 450,width: 500,padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Add a product",style: Theme.of(context).textTheme.headline2,),
            const SizedBox(height: 20,),
            CustomDropdownButton(
              items: Category.categories.map((category) => category.name).toList(),
              onChanged: (value){
                product=product.copyWith(category: value);
                print(product);
              },
            ),
            const SizedBox(height: 10,),
            CustomTextFormField(maxLines: 1, title: "Name", initialValue: "", hasTitle: true,
                onChanged: (value){
                  product=product.copyWith(name: value);
                }
            ),
            CustomTextFormField(maxLines: 1, title: "Price", initialValue: "", hasTitle: true,
                onChanged: (value){
                  product=product.copyWith(price: double.parse(value));
                }
            ),
            CustomTextFormField(maxLines: 1, title: "Imagr URL", initialValue: "", hasTitle: true,
                onChanged: (value){
                  product=product.copyWith(imageUrl: value);
                }
            ),
            CustomTextFormField(maxLines: 3, title: "Description", initialValue: "", hasTitle: true,
                onChanged: (value){
                  product=product.copyWith(description: value);
                }
            ),
            ElevatedButton(onPressed: (){
              BlocProvider.of<ProductBloc>(context).add(AddProducts(product: product));
              Navigator.pop(context);
            },
                child: Text("Save",style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white),)
            )
          ],
        ),
      ),
    );
  }

}


// Product product = const Product(
//
//     name: '',
//     category: '',
//     description: '',
//     imageUrl: '',
//     price: 0);
//
// return Dialog(
// child: Container(height: 450,width: 500,padding: EdgeInsets.all(20),
// child: Column(
// children: [
// Text("Add a product",style: Theme.of(context).textTheme.headline2,),
// const SizedBox(height: 20,),
// CustomDropdownButton(
// items: Category.categories.map((category) => category.name).toList(),
// onChanged: (value){
// product=product.copyWith(category: value);
// print(product);
// },
// ),
// const SizedBox(height: 10,),
// CustomTextFormField(maxLines: 1, title: "Name", initialValue: "", hasTitle: true,
// onChanged: (value){
// product=product.copyWith(name: value);
// }
// ),
// CustomTextFormField(maxLines: 1, title: "Price", initialValue: "", hasTitle: true,
// onChanged: (value){
// product=product.copyWith(price: double.parse(value));
// }
// ),
// CustomTextFormField(maxLines: 1, title: "Imagr URL", initialValue: "", hasTitle: true,
// onChanged: (value){
// product=product.copyWith(imageUrl: value);
// }
// ),
// CustomTextFormField(maxLines: 3, title: "Description", initialValue: "", hasTitle: true,
// onChanged: (value){
// product=product.copyWith(description: value);
// }
// ),
// ElevatedButton(onPressed: (){
// BlocProvider.of<ProductBloc>(context).add(AddProducts(product: product));
// Navigator.pop(context);
// },
// child: Text("Save",style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white),)
// )
// ],
// ),
// ),
// );


//og product_card was-
/*
import 'package:bloomscape_backend/bloc/blocs.dart';
import 'package:bloomscape_backend/widgets/custom_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/category_model.dart';
import '../model/product_model.dart';
import 'custom_dropdown_button.dart';
class ProductCard extends StatelessWidget {
  const ProductCard({Key? key,required this.product,required this.index}) : super(key: key);

  final Product product;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 10),

      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: index==0?
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: (){
                showDialog(context: context, builder:(BuildContext context){

                  Product product = const Product(

                      name: '',
                      category: '',
                      description: '',
                      imageUrl: '',
                      price: 0);

                  return Dialog(
                    child: Container(height: 450,width: 500,padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text("Add a product",style: Theme.of(context).textTheme.headline2,),
                          const SizedBox(height: 20,),
                          CustomDropdownButton(
                            items: Category.categories.map((category) => category.name).toList(),
                            onChanged: (value){
                              product=product.copyWith(category: value);
                              print(product);
                            },
                          ),
                          const SizedBox(height: 10,),
                          CustomTextFormField(maxLines: 1, title: "Name", initialValue: "", hasTitle: true,
                              onChanged: (value){
                                product=product.copyWith(name: value);
                              }
                          ),
                          CustomTextFormField(maxLines: 1, title: "Price", initialValue: "", hasTitle: true,
                              onChanged: (value){
                                product=product.copyWith(price: double.parse(value));
                              }
                          ),
                          CustomTextFormField(maxLines: 1, title: "Imagr URL", initialValue: "", hasTitle: true,
                              onChanged: (value){
                                product=product.copyWith(imageUrl: value);
                              }
                          ),
                          CustomTextFormField(maxLines: 3, title: "Description", initialValue: "", hasTitle: true,
                              onChanged: (value){
                                product=product.copyWith(description: value);
                              }
                          ),
                          ElevatedButton(onPressed: (){
                            BlocProvider.of<ProductBloc>(context).add(AddProducts(product: product));
                            Navigator.pop(context);
                          },
                              child: Text("Save",style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white),)
                          )
                        ],
                      ),
                    ),
                  );
                });
              },
              iconSize: 40, icon: Icon(Icons.add_circle,color: Theme.of(context).primaryColor,)),
          Text("Add a product",style: Theme.of(context).textTheme.headline5,),
        ],
      ):
      Column(
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



 */