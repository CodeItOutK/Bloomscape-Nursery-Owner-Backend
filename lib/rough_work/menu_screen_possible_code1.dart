import 'package:bloomscape_backend/bloc/blocs.dart';
import 'package:bloomscape_backend/config/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/category_model.dart';
import '../../model/product_model.dart';
import '../../widgets/category_listTile.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/custom_layout.dart';
import '../../widgets/product_card.dart';
import '../../widgets/product_listTile.dart';

class MenuScreenPossible extends StatelessWidget {
  const MenuScreenPossible({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: CustomLayout(title: 'Nursery Name',
        widgets: [
          _buildProductCarousel(),
          const SizedBox(height: 10,),

          Responsive.isWideDesktop(context)||Responsive.isDesktop(context)?
          Container(constraints: BoxConstraints(minHeight: 300,maxHeight: 1000),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child:buildCategories(context),

                ),
                const SizedBox(width: 20,),
                Expanded(
                  child: buildProducts(context),
                ),
              ],
            ),
          ):
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCategories(context),
              const SizedBox(height: 20,),
              buildProducts(context),
            ],
          ),

        ],
      ),
    );
  }

  BlocBuilder<ProductBloc, ProductState> _buildProductCarousel() {
    return BlocBuilder<ProductBloc,ProductState>(
          builder: (context,state) {
            if(state is ProductLoading){
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            }
            if(state is ProductLoaded){
              return SizedBox(width: double.infinity,height: 200,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.products.length,
                      itemBuilder: (BuildContext context,int index) {
                        return ProductCard(product: state.products[index],);
                      }
                  ),
                ),
              );
            }else{
              return Text("Something went wrong");
            }
          }
        );
  }

}

// class CustomLayout extends StatelessWidget {
//   const CustomLayout({
//     super.key,
//   });

@override
Widget build(BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Nursery Name",style: Theme.of(context).textTheme.headline3,),
          SizedBox(height: 20,),
          SizedBox(width: double.infinity,height: 200,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: Product.products.length,
                itemBuilder: (BuildContext context,int index){
                  return ProductCard(product:Product.products[index],);
                },
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Responsive.isWideDesktop(context)||Responsive.isDesktop(context)?
          Container(constraints:const BoxConstraints(minHeight: 300,maxHeight: 1000),
            child: Row(
              children: [

                Expanded(
                    child: buildCategories(context)
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: buildProducts(context),
                )
              ],
            ),
          ):
          Column(
            children: [

              buildCategories(context),
              const SizedBox(height: 20,),
              buildProducts(context)
            ],
          ),
          SizedBox(height: 20,),

          Container(
            width: double.infinity,
            constraints: BoxConstraints(minHeight: 75),
            color: Theme.of(context).primaryColor,
            child: Center(child: Text("Some ads here"),),
          ),
        ],
      ),
    ),
  );
}
//  const SizedBox(height: 20,),
Container buildProducts(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(20),
    color: Theme.of(context).backgroundColor,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Products",style: Theme.of(context).textTheme.headline4,),

        BlocBuilder<ProductBloc,ProductState>(
          builder: (context, state) {
            if(state is ProductLoading){
              return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,));
            }
            if(state is ProductLoaded){
              return ReorderableListView(
                  shrinkWrap: true,
                  children: [
                    for(int ind=0;ind<state.products.length;ind++)
                      ProductListTile(product: state.products[ind],onTap: (){},
                        key:ValueKey(state.products[ind].id),
                      ),

                  ],
                  onReorder: (oldIndex,newIndex){
                    context.read<ProductBloc>().add(SortProducts(oldIndex: oldIndex, newIndex: newIndex),);
                  }
              );


            }else{
              return Text("Something Went Wrong");
            }
          },
        ),


        // SizedBox(height: 20,),

        // ...Product.products.map((product){
        //   return ProductListTile(product: product,);
        // }).toList()
      ],
    ),
  );
}


Container buildCategories(BuildContext context) {
  return
    Container(
      padding: EdgeInsets.all(20),
      color: Theme.of(context).backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Categories",style: Theme.of(context).textTheme.headline4,),

          BlocBuilder<CategoryBloc,CategoryState>(
            builder: (context, state) {
              if(state is CategoryLoading){
                return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,));
              }
              if(state is CategoryLoaded){
                return ReorderableListView(
                    shrinkWrap: true,
                    children: [
                      for(int index=0;index<state.categories.length;index++)
                        CategoryListTile(category: state.categories[index],
                          onTap: (){
                            context.read<CategoryBloc>().add(SelectCategory(state.categories[index]));
                          },
                          key:ValueKey(state.categories[index].id),
                        ),

                    ],
                    onReorder: (oldIndex,newIndex){
                      context.read<CategoryBloc>().add(SortCategories(oldIndex: oldIndex, newIndex: newIndex),);
                    }
                );


              }else{
                return Text("Something Went Wrong");
              }
            },
          ),
        ],
      ),
    );
}











//-------------DO NOT CROSS------------------------------------------------------------------------------
//The og working code-----

// import 'package:bloomscape_backend/bloc/blocs.dart';
// import 'package:bloomscape_backend/config/responsive.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../model/category_model.dart';
// import '../../model/product_model.dart';
// import '../../widgets/category_listTile.dart';
// import '../../widgets/custom_appbar.dart';
// import '../../widgets/custom_drawer.dart';
// import '../../widgets/custom_layout.dart';
// import '../../widgets/product_card.dart';
// import '../../widgets/product_listTile.dart';
//
// class MenuScreen extends StatelessWidget {
//   const MenuScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar: const CustomAppBar(),
//       drawer: const CustomDrawer(),
//       body: Row(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Expanded(
//             flex: 4,
//             child: SingleChildScrollView(
//
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Nursery Menu",style: Theme.of(context).textTheme.headline3,),
//                     const SizedBox(height: 20,),
//                     SizedBox(width: double.infinity,height: 200,
//                       child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: Product.products.length,
//                           itemBuilder: (BuildContext context,int index) {
//                             return ProductCard(product: Product.products[index], index: index);
//                           }
//                       ),
//                     ),
//                     const SizedBox(height: 20,),
//                     Responsive.isWideDesktop(context)||Responsive.isDesktop(context)?
//                     Container(constraints: BoxConstraints(minHeight: 300,maxHeight: 1000),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child:buildCategories(context),
//
//                           ),
//                           const SizedBox(width: 10,),
//                           Expanded(
//                             child: buildProducts(context),
//
//                           ),
//                         ],
//                       ),
//                     ):
//                     Column(
//                       children: [
//                         buildCategories(context),
//                         const SizedBox(height: 10,),
//                         buildProducts(context),
//                       ],
//                     ),
//                     SizedBox(height: 20,),
//                     Container(
//                       width: double.infinity,
//                       constraints:const BoxConstraints(minHeight: 75) ,
//                       color: Theme.of(context).primaryColor,
//                       child: const Center(
//                         child: Text("Some Ads here"),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Responsive.isWideDesktop(context)||Responsive.isDesktop(context)?
//           Expanded(
//             child: Container(
//               margin: EdgeInsets.only(top: 20,bottom: 20,right: 20),
//               child: Center(child: Text("Some adds here")),
//               color: Theme.of(context).backgroundColor,
//             ),
//           ):SizedBox(),
//
//
//
//
//           // Responsive.isWideDesktop(context)||Responsive.isDesktop(context)?
//           // Expanded(
//           //   child: Container(
//           //     margin: EdgeInsets.only(top:20,right: 20,bottom: 20),
//           //     color: Theme.of(context).backgroundColor,
//           //     child:const Center(child: const  Text("Some Adds here...")),),
//           // ):SizedBox(),
//         ],
//       ),
//     );
//   }
//
// }
//
// // class CustomLayout extends StatelessWidget {
// //   const CustomLayout({
// //     super.key,
// //   });
//
// @override
// Widget build(BuildContext context) {
//   return SingleChildScrollView(
//     child: Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Nursery Name",style: Theme.of(context).textTheme.headline3,),
//           SizedBox(height: 20,),
//           SizedBox(width: double.infinity,height: 200,
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 10.0),
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 scrollDirection: Axis.horizontal,
//                 itemCount: Product.products.length,
//                 itemBuilder: (BuildContext context,int index){
//                   return ProductCard(product:Product.products[index],index:index);
//                 },
//               ),
//             ),
//           ),
//           const SizedBox(height: 20,),
//           Responsive.isWideDesktop(context)||Responsive.isDesktop(context)?
//           Container(constraints:const BoxConstraints(minHeight: 300,maxHeight: 1000),
//             child: Row(
//               children: [
//
//                 Expanded(
//                     child: buildCategories(context)
//                 ),
//                 const SizedBox(width: 10,),
//                 Expanded(
//                   child: buildProducts(context),
//                 )
//               ],
//             ),
//           ):
//           Column(
//             children: [
//
//               buildCategories(context),
//               const SizedBox(height: 20,),
//               buildProducts(context)
//             ],
//           ),
//           SizedBox(height: 20,),
//
//           Container(
//             width: double.infinity,
//             constraints: BoxConstraints(minHeight: 75),
//             color: Theme.of(context).primaryColor,
//             child: Center(child: Text("Some ads here"),),
//           ),
//         ],
//       ),
//     ),
//   );
// }
// //  const SizedBox(height: 20,),
// Container buildProducts(BuildContext context) {
//   return Container(
//     padding: EdgeInsets.all(20),
//     color: Theme.of(context).backgroundColor,
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Products",style: Theme.of(context).textTheme.headline4,),
//
//         BlocBuilder<ProductBloc,ProductState>(
//           builder: (context, state) {
//             if(state is ProductLoading){
//               return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,));
//             }
//             if(state is ProductLoaded){
//               return ReorderableListView(
//                   shrinkWrap: true,
//                   children: [
//                     for(int ind=0;ind<state.products.length;ind++)
//                       ProductListTile(product: state.products[ind],onTap: (){},
//                         key:ValueKey(state.products[ind].id),
//                       ),
//
//                   ],
//                   onReorder: (oldIndex,newIndex){
//                     context.read<ProductBloc>().add(SortProducts(oldIndex: oldIndex, newIndex: newIndex),);
//                   }
//               );
//
//
//             }else{
//               return Text("Something Went Wrong");
//             }
//           },
//         ),
//
//
//         // SizedBox(height: 20,),
//
//         // ...Product.products.map((product){
//         //   return ProductListTile(product: product,);
//         // }).toList()
//       ],
//     ),
//   );
// }
//
//
// Container buildCategories(BuildContext context) {
//   return
//     Container(
//       padding: EdgeInsets.all(20),
//       color: Theme.of(context).backgroundColor,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Categories",style: Theme.of(context).textTheme.headline4,),
//
//           BlocBuilder<CategoryBloc,CategoryState>(
//             builder: (context, state) {
//               if(state is CategoryLoading){
//                 return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,));
//               }
//               if(state is CategoryLoaded){
//                 return ReorderableListView(
//                     shrinkWrap: true,
//                     children: [
//                       for(int index=0;index<state.categories.length;index++)
//                         CategoryListTile(category: state.categories[index],
//                           onTap: (){
//                             context.read<CategoryBloc>().add(SelectCategory(state.categories[index]));
//                           },
//                           key:ValueKey(state.categories[index].id),
//                         ),
//
//                     ],
//                     onReorder: (oldIndex,newIndex){
//                       context.read<CategoryBloc>().add(SortCategories(oldIndex: oldIndex, newIndex: newIndex),);
//                     }
//                 );
//
//
//               }else{
//                 return Text("Something Went Wrong");
//               }
//             },
//           ),
//         ],
//       ),
//     );
// }
// // Container buildProducts(BuildContext context) {
// //   return Container(
// //                           padding: EdgeInsets.all(20),
// //                           color: Theme.of(context).backgroundColor,
// //                           child: Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               Text("Products",style: Theme.of(context).textTheme.headline4,),
// //
// //                               BlocBuilder<ProductBloc,ProductState>(
// //                                 builder: (context, state) {
// //                                   if(state is ProductLoading){
// //                                     return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,));
// //                                   }
// //                                   if(state is ProductLoaded){
// //                                     return ReorderableListView(
// //                                         shrinkWrap: true,
// //                                         children: [
// //                                           for(int ind=0;ind<state.products.length;ind++)
// //                                             ProductListTile(product: state.products[ind],onTap: (){},
// //                                               key:ValueKey(state.products[ind].id),
// //                                             ),
// //
// //                                         ],
// //                                         onReorder: (oldIndex,newIndex){
// //                                           context.read<ProductBloc>().add(SortProducts(oldIndex: oldIndex, newIndex: newIndex),);
// //                                         }
// //                                     );
// //
// //
// //                                   }else{
// //                                     return Text("Something Went Wrong");
// //                                   }
// //                                 },
// //                               ),
// //
// //
// //                               // SizedBox(height: 20,),
// //
// //                               // ...Product.products.map((product){
// //                               //   return ProductListTile(product: product,);
// //                               // }).toList()
// //                             ],
// //                           ),
// //                         );
// // }
// // }
//
//
// // class CustomDrawer extends StatelessWidget {
// //   const CustomDrawer({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //
// //     Map<String,dynamic>screens={
// //       'Dashboard':{
// //         'routeName':'/dashboard',
// //         'icon': const Icon(Icons.dashboard),
// //       },
// //       'Menu':{
// //         'routeName':'/menu',
// //         'icon': const Icon(Icons.menu_book),
// //       },
// //       'Opening Hours':{
// //         'routeName':'/opening-hours',
// //         'icon': const Icon(Icons.lock_clock),
// //       },
// //       'LogOut':{
// //         'routeName':'/logout',
// //         'icon': const Icon(Icons.logout_outlined),
// //       }
// //
// //     };
// //
// //     return Drawer(
// //       child: ListView(
// //         children: [
// //           SizedBox(
// //             height: 65,
// //             child: DrawerHeader(
// //               decoration: BoxDecoration(
// //                 color: Theme.of(context).primaryColor,
// //               ),
// //               child: Text("Your Nursery Name",
// //                 style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.white),
// //               ),
// //             ),
// //           ),
// //
// //           ...screens.entries.map((screen){
// //             return ListTile(
// //               leading: screen.value['icon'],
// //               title: Text(screen.key),
// //               onTap: (){
// //                 Navigator.pushNamed(context, screen.value['routeName']);
// //               },
// //             );
// //           },)
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
// // class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
// //   const CustomAppBar({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return AppBar(
// //       title: Text("Your Nursery Name",
// //         style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.white),
// //       ),
// //       centerTitle: false,
// //     );
// //
// //
// //   }
// //
// //   @override
// //   // TODO: implement preferredSize
// //   Size get preferredSize => Size.fromHeight(56.0);
// // }
