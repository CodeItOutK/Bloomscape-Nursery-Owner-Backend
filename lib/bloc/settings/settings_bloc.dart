
import 'dart:async';

import 'package:bloomscape_backend/model/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/nursery_model.dart';
import '../../repositories/Nursery/nursery_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent,SettingsState>{
  final NurseryRepository _nurseryRepository;
  StreamSubscription? _nurserySubscription;
  SettingsBloc({required NurseryRepository nurseryRepository}):_nurseryRepository=nurseryRepository,super(SettingsLoading()){

    on<LoadSettings>(_onLoadSettings);
    on<UpdateSettings>(_onUpdateSettings);
    on<UpdateOpeningHours>(_onUpdateOpeningHours);

    _nurserySubscription=_nurseryRepository.getNursery().listen((nursery) {
      print(nursery);
      add(LoadSettings(nursery: nursery));
    });

  }
  void _onLoadSettings(LoadSettings event,Emitter<SettingsState>emit,)async{
    await Future<void>.delayed(Duration(seconds: 1));
    emit(SettingsLoaded(event.nursery));
  }
  void _onUpdateSettings(UpdateSettings event,Emitter<SettingsState>emit,){
    if(event.isUpdateComplete){
      _nurseryRepository.editNurserySettings(event.nursery);
    }


    emit(SettingsLoaded(event.nursery));
  }

  void _onUpdateOpeningHours(UpdateOpeningHours event,Emitter<SettingsState>emit,){
    final state=this.state;
    if(state is SettingsLoaded){
      List<OpeningHours> openingHoursList=(state.nursery.openingHours!.map((openingHours){
        return openingHours.id==event.openingHours.id?event.openingHours:openingHours;
      })).toList();

      _nurseryRepository.editNurseryOpeningHours(openingHoursList);
      emit(
        SettingsLoaded(
          state.nursery.copyWith(openingHours: openingHoursList),
        ),
      );

    }
  }

  @override
  Future<void>close()async{
    _nurserySubscription?.cancel();
    super.close();
  }

}