import 'package:bloomscape_backend/bloc/blocs.dart';
import 'package:equatable/equatable.dart';
import '../../model/category_model.dart';
import 'package:bloc/bloc.dart';
part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent,CategoryState>{
  CategoryBloc():super(CategoryLoading()){
    on<LoadCategories>(_onLoadCategories);
    on<SortCategories>(_onSortCategories);
    on<SelectCategory>(_onSelectCategory);
  }

  void _onLoadCategories(LoadCategories event, Emitter<CategoryState>emit) async {

    await Future<void>.delayed(const Duration(seconds: 1));
    emit(CategoryLoaded(categories: event.categories));
  }

  void _onSortCategories(SortCategories event, Emitter<CategoryState>emit) async {
    final state=this.state as CategoryLoaded;
    emit(CategoryLoading());
    await Future<void>.delayed(Duration(seconds: 1));

    int newIndex = event.newIndex>event.oldIndex?event.newIndex-1:event.newIndex;
    try{
      Category selectedCatregory=state.categories[event.oldIndex];
      List<Category>sortedCategories= List.from(state.categories)..remove(selectedCatregory)..insert(newIndex, selectedCatregory);
      emit(CategoryLoaded(categories: sortedCategories));
    }catch(_){

    }
  }

  void _onSelectCategory(SelectCategory event, Emitter<CategoryState>emit){
    final state=this.state as CategoryLoaded;
    emit(CategoryLoaded(categories: state.categories,selectedCategory: event.category));
  }

}