part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable{
  const SettingsEvent();
  @override
  List<Object>get props=>[];

}

class LoadSettings extends SettingsEvent{
  final Nursery nursery;

  const LoadSettings({this.nursery=const Nursery()});

  @override
  List<Object>get props=>[nursery];

}

class UpdateSettings extends SettingsEvent{
  final Nursery nursery;
  final bool isUpdateComplete;

  UpdateSettings({required this.nursery,this.isUpdateComplete=false});
  @override
  List<Object>get props=>[isUpdateComplete,nursery];
}

class UpdateOpeningHours extends SettingsEvent{
  final OpeningHours openingHours;

  UpdateOpeningHours({required this.openingHours});
  @override
  List<Object>get props=>[openingHours];
}