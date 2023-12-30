part of 'settings_bloc.dart';
abstract class SettingsState extends Equatable{
  const SettingsState();
  @override
  List<Object>get props=>[];

}

class SettingsLoading extends SettingsState{}

class SettingsLoaded extends SettingsState{
  final Nursery nursery;

  SettingsLoaded(this.nursery);
  List<Object>get props=>[nursery];

}