import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class Product extends Equatable{
 final String? id;
 final String name;
 final String category;
 final String description;
 final String imageUrl;
 final double price;
 final String? nurseryId;

 const  Product({this.id,this.nurseryId,required this.name,required this.category,required this.description,required this.imageUrl,required this.price,});

  Product copyWith({
   String? id,
   String? name,
   String? category,
   String? description,
   String? imageUrl,
   double? price,
    String? nurseryId,
}) {
    
    return Product(id: id??this.id, name: name??this.name,nurseryId:nurseryId??this.nurseryId ,category: category??this.category, description: description??this.description, imageUrl: imageUrl??this.imageUrl, price: price??this.price,);
  }

 Map<String,dynamic> toDocument(){
   return{
     'id':id,'name':name,'category':category,'description':description,'imageUrl':imageUrl,'price':price,'nurseryId':nurseryId
   };
 }

  factory Product.fromSnapshot(Map<String,dynamic> snap){
    return Product(id: snap["id"].toString(),nurseryId:snap["nurseryId"], name: snap["name"], category: snap["category"], description: snap["description"], imageUrl: snap["imageUrl"], price: snap["price"]);
 }

  @override
  // TODO: implement props
  List<Object?> get props => [id,name,category,description,imageUrl,price,nurseryId];

  static List<Product>products=const[
    Product(id: '1',nurseryId:"MbyvrvKY1hdNohNU11EL", name: "Rose", category: "Flowering Plants", description: "Flowers,varying range of colors", imageUrl: "assets/images/diff_plants/flowering/col_roses.jpg", price: 246,),
    Product(id: '2',nurseryId:"MbyvrvKY1hdNohNU11EL", name: "Lotus", category: "Aquatic Plants", description: "Flowers,varying range of colors", imageUrl: "assets/images/diff_plants/aquatic/lotus.jpg", price: 375, ),
    Product(id: '3',nurseryId:"MbyvrvKY1hdNohNU11EL", name: "Rose", category: "Flowering Plants", description: "Flowers,varying range of colors", imageUrl: "assets/images/diff_plants/flowering/col_roses.jpg", price: 246, ),
    Product(id: '4',nurseryId:"MbyvrvKY1hdNohNU11EL", name: "Rose", category: "Flowering Plants", description: "Flowers,varying range of colors", imageUrl: "assets/images/diff_plants/flowering/col_roses.jpg", price: 246, ),
    Product(id: '5',nurseryId:"MbyvrvKY1hdNohNU11EL", name: "Lotus", category: "Aquatic Plants", description: "Flowers,varying range of colors", imageUrl: "assets/images/diff_plants/aquatic/lotus.jpg", price: 375,),
    Product(id: '6',nurseryId:"MbyvrvKY1hdNohNU11EL", name: "Lotus", category: "Aquatic Plants", description: "Flowers,varying range of colors", imageUrl: "assets/images/diff_plants/aquatic/lotus.jpg", price: 375,),
    Product(id: '7',nurseryId:"MbyvrvKY1hdNohNU11EL", name: "Lotus", category: "Aquatic Plants", description: "Flowers,varying range of colors", imageUrl: "assets/images/diff_plants/aquatic/lotus.jpg", price: 375,),
    Product(id: '8', nurseryId:"MbyvrvKY1hdNohNU11EL",name: "Lotus", category: "Aquatic Plants", description: "Flowers,varying range of colors", imageUrl: "assets/images/diff_plants/aquatic/lotus.jpg", price: 375,),
    Product(id: '9',nurseryId:"MbyvrvKY1hdNohNU11EL", name: "Lotus", category: "Aquatic Plants", description: "Flowers,varying range of colors", imageUrl: "assets/images/diff_plants/aquatic/lotus.jpg", price: 375,),
  ];
}