import 'package:bloomscape_backend/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'category_model.dart';
import 'opening_hours_model.dart';

class Nursery extends Equatable{
  final String? id;
  final String? name;
  final String? imageUrl;
  final String? description;
  final List<String>? tags;
  final List<Product>?products ;
  final List<Category>?categories ;
  final List<OpeningHours>?openingHours ;

  const Nursery({this.id, this.name, this.imageUrl, this.description, this.tags, this.products, this.categories, this.openingHours});

  @override
  // TODO: implement props
  List<Object?> get props => [id,name,imageUrl,description,tags,products,categories,openingHours];

  Nursery copyWith({
   String? id,
   String? name,
   String? imageUrl,
   String? description,
   List<String>? tags,
   List<Product>?products,
   List<Category>?categories,
   List<OpeningHours>?openingHours,
  }) {

    return Nursery(id: id??this.id, name: name??this.name,  description: description??this.description, imageUrl: imageUrl??this.imageUrl, tags: tags??this.tags, products:products ??this.products, categories:categories ??this.categories, openingHours:openingHours ??this.openingHours);
  }

  Map<String,dynamic>toDocument(){
    return{
      'id':id??'', 'name':name??'', 'imageUrl':imageUrl??'', 'description':description??'',
      'tags':tags??[], 'categories':categories!.map((category){
        return category.toDocument();
      }).toList(),
      'products':products!.map((product){
        return product.toDocument();
      },).toList(),
      'openingHours':openingHours!.map((openingHour){
        return openingHour.toDocument();
      },).toList(),
    };
  }
  factory Nursery.fromSnapshot(DocumentSnapshot snap){
    return Nursery(
      id:snap.id,name: snap['name'], imageUrl: snap['imageUrl'], description: snap['description'],
      tags:(snap['tags'] as List).map((tag){
        return tag as String;
      }).toList(),
      categories:(snap['categories'] as List).map((category){
        return Category.fromSnapshot(category);
      }).toList(),
      products: (snap['products'] as List).map((product){
        return Product.fromSnapshot(product);
      }).toList(),
      openingHours: (snap['openingHours'] as List).map((openingHour){
        return OpeningHours.fromSnapshot(openingHour);
      }).toList(),
    );
  }

  static List<Nursery>nurseries=[
    Nursery(
      id:"1",
      name: "Green Wood",
      imageUrl: 'assets/images/shop1.jpg',
      description: "Welcome to GreenWood Nursery – where green dreams come to life! Explore a curated selection of thriving plants, perfect for any space. Whether you're a gardening pro or just starting out, our knowledgeable team is here to assist you. Transform your surroundings with the timeless beauty of GreenWood.",
      tags: ['Show Plants', 'Hangings','Bonsai plants'],
      products: Product.products,
      categories: Category.categories,
      openingHours:OpeningHours.openingHoursList,
    )
  ];

}