import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Category extends Equatable{
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final int index;

  const  Category ({required this.id,required this.name,required this.description,required this.imageUrl,required this.index});

  Category  copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    int? index,
  }) {

    return Category (id: id??this.id, name: name??this.name, description: description??this.description, imageUrl: imageUrl??this.imageUrl, index: index??this.index);
  }

  Map<String,dynamic> toDocument(){
    return{
      'id':id,'name':name,'description':description,'imageUrl':imageUrl,'index':index
    };
  }

  factory Category .fromSnapshot(Map<String,dynamic> snap){
    return Category (id: snap["id"].toString(), name: snap["name"],  description: snap["description"], imageUrl: snap["imageUrl"],  index: snap["index"]);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id,name,description,imageUrl,index];

  static List<Category>categories=const[
    Category(id: '1',name: 'Hangings', imageUrl: 'assets/images/plant_categories/Balcony_hanging_plants.jpg',description: " Beautiful trailing plants perfect for hanging baskets and adding a touch of greenery to your balcony.", index: 0),
    Category(id: '2', name: 'Show Plants', imageUrl: 'assets/images/plant_categories/show_plants.jpg',description: "Exquisite and unique specimens that stand out for their exceptional beauty, making them focal points in any garden or indoor space.", index: 1),
    Category(id: '3', name: 'Climbers/Bel', imageUrl:'assets/images/plant_categories/Indian_bel.jpg',description: "Graceful vines that climb and adorn your garden, providing a natural and charming screen.",  index: 2),
    Category(id: '4', name: 'Fruits', imageUrl:'assets/images/plant_categories/fruits.jpg',description: "Fruit-bearing trees and shrubs that offer a delicious harvest, bringing the joy of homegrown fruits to your table.",  index: 3),
    Category(id: '5', name: 'Herbs', imageUrl:'assets/images/plant_categories/herbs.jpg',description: "Fragrant and flavorful plants, ideal for culinary and medicinal purposes, enhancing both your garden and kitchen.",  index: 4),
    Category(id: '6',  name: 'Flowering Plants',imageUrl: 'assets/images/plant_categories/Flowering_plants.jpg',description: "Bursting with vibrant blooms, these plants bring color and joy to your garden, creating a visually stunning landscape.",  index: 5),
    Category(id: '7', name: 'Vegetable Plants', imageUrl:'assets/images/plant_categories/vegetables.jpg',description: " Nutrient-rich plants that yield delicious and fresh vegetables, turning your garden into a bountiful kitchen resource.",  index: 6),
    Category(id: '8', name: 'Aquatic Plants', imageUrl:'assets/images/plant_categories/aquatic_plants.jpg',description: "Stunning water-loving plants that thrive in ponds or water features, adding a serene and natural touch to your aquatic environment.",  index: 7),
  ];
}