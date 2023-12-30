import 'package:bloomscape_backend/bloc/settings/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc,SettingsState>(
      builder: (context,state) {
        if (state is SettingsLoading) {
          return AppBar(
            backgroundColor: Theme
                .of(context)
                .primaryColor,
            title: Text("Your Nursery Name",
              style: Theme
                  .of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: Colors.white),
            ),
            centerTitle: false,
          );
        }
        if (state is SettingsLoaded) {
          return AppBar(
            backgroundColor: Theme
                .of(context)
                .primaryColor,
            title: Text(
              (state.nursery.name == null) ? 'Set Name for Your Nursery' : state
                  .nursery.name!,
              style: Theme
                  .of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: Colors.white),
            ),
            centerTitle: false,
          );
        } else {
          return const Text("Something went wrong");
          }
          }
        );
      }



  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(56.0);
}