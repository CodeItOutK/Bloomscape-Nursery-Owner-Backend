// import 'package:bloomscape_backend/bloc/product/product_event.dart';
import 'dart:async';
import 'dart:async';
import 'dart:async';

import 'package:bloomscape_backend/repositories/Nursery/nursery_repository.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/category_model.dart';
import '../../model/product_model.dart';
import '../../model/product_model.dart';
import '../category/category_bloc.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent,ProductState> {
  final NurseryRepository _nurseryRepository;
  StreamSubscription? _nurserySubscription;
  final CategoryBloc _categoryBloc;
  StreamSubscription? _categorySubscription;
  ProductBloc({required CategoryBloc categoryBloc,required NurseryRepository nurseryRepository})
      :_categoryBloc=categoryBloc,_nurseryRepository=nurseryRepository,

        super (ProductLoading()){
    on<LoadProducts>(_onLoadProducts);
    on<FilterProducts>(_onFilterProducts);
    on<SortProducts>(_onSortProducts);
    on<AddProducts>(_onAddProducts);

    _categorySubscription=_categoryBloc.stream.listen((state) {
      if(state is CategoryLoaded && state.selectedCategory!=null){
        add(FilterProducts(category: state.selectedCategory!),
        );
      }else{}
    });

    _nurserySubscription=_nurseryRepository.getNursery().listen((nursery) {
      add(LoadProducts(products: nursery.products!));
    });

  }
  void _onAddProducts(AddProducts event,Emitter<ProductState>emit,) async {
    if(state is ProductLoaded){
      List<Product>newProducts=List.from((state as ProductLoaded).products)..add(event.product);

      _nurseryRepository.editProducts(newProducts);
      emit(ProductLoaded(
        products: newProducts,
      ));
    }
  }

  void _onLoadProducts(LoadProducts event,Emitter<ProductState>emit,) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    emit(ProductLoaded(products: event.products));
  }

  void _onFilterProducts(FilterProducts event,Emitter<ProductState>emit,) async {
    emit(ProductLoading());
    await Future<void>.delayed(Duration(seconds: 1));
    List<Product>filteredProducts=Product.products.where((product) => product.category==event.category.name).toList();
    emit(ProductLoaded(products: filteredProducts));
  }

  void _onSortProducts(SortProducts event,Emitter<ProductState>emit,) async {
    final state=this.state as ProductLoaded;
    emit(ProductLoading());
    await Future<void>.delayed(const Duration(seconds: 1));

    int newIndex = event.newIndex>event.oldIndex?event.newIndex-1:event.newIndex;
    try{
    Product selectedProduct=state.products[event.oldIndex];
    List<Product>sortedProducts= List.from(state.products)..remove(selectedProduct)..insert(newIndex, selectedProduct);
    emit(ProductLoaded(products: sortedProducts));
    }catch(_){

    }
  }

  @override
  Future<void>close()async{
    _categorySubscription?.cancel();
    _nurserySubscription?.cancel();
    super.close();
  }
}