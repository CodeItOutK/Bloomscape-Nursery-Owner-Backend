import 'package:bloomscape_backend/bloc/blocs.dart';
import 'package:bloomscape_backend/bloc/settings/settings_bloc.dart';
import 'package:bloomscape_backend/config/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/category_model.dart';
import '../../widgets/custom_layout.dart';
import '../../model/product_model.dart';
import '../../widgets/category_listTile.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/custom_textform_field.dart';
import '../../widgets/opening_hours_settings.dart';
import '../../widgets/product_card.dart';
import '../../widgets/product_listTile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: CustomLayout(
          title:'Settings',
          widgets:[
            _buildImage(),
            Responsive.isDesktop(context) || Responsive.isWideDesktop(context)
            ?
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(child: buildBasicInformation(context)),
                  const SizedBox(width: 10,),
                  Expanded(child: buildNurseryDescription(context))
                ],
              ),
            ):
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   buildBasicInformation(context),
                  const SizedBox(height: 10,),
                  buildNurseryDescription(context),
                ],
              ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text("Opening Hours",style: Theme.of(context).textTheme.headline4,),
            ),

            buildOpeningHours()

           ],

          ),

      );

  }

  BlocBuilder<SettingsBloc, SettingsState> buildOpeningHours() {
    return BlocBuilder<SettingsBloc,SettingsState>(
            builder: (context,state) {
              if(state is SettingsLoading){
                return Center(child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),);
              }
              if(state is SettingsLoaded){
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.nursery.openingHours!.length,
                    itemBuilder: (context,index){
                    var openingHours=state.nursery.openingHours![index];
                      return OpeningHoursSettings(
                        openingHours: openingHours,
                        onSliderChanged: (value){
                          context.read<SettingsBloc>().add(UpdateOpeningHours(openingHours: openingHours.copyWith(openAt: value.start,closeAt: value.end)
                          ));
                        },
                        onCheckboxChanged: (value){
                          context.read<SettingsBloc>().add(UpdateOpeningHours(openingHours: openingHours!.copyWith(isOpen: !openingHours.isOpen)
                          )
                          );
                        },
                      );
                    }
                );
              }
              else{
                return Text("Something went wrong");
              }
            }
          );
  }

  Container buildBasicInformation(BuildContext context) {
    return Container(
                padding: const EdgeInsets.all(20),
                color: Theme.of(context).backgroundColor,
                child: BlocBuilder<SettingsBloc,SettingsState>(
                  builder: (context,state) {
                    if(state is SettingsLoading){
                      return Center(child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),);
                    }
                    if(state is SettingsLoaded){
                      return Column(
                        children: [
                          Text("Basic Information",style: Theme.of(context).textTheme.headline4,),
                          const SizedBox(height: 20,),
                          CustomTextFormField(maxLines: 1,title: 'Name',hasTitle: true,initialValue: (state.nursery.name!=null)?state.nursery.name!:"",
                            onChanged: (value){
                            context.read<SettingsBloc>().add(UpdateSettings(nursery: state.nursery.copyWith(name: value)));
                          },
                            onFocusChanged: (hasFocus){
                              context.read<SettingsBloc>().add(UpdateSettings(
                                  isUpdateComplete: true,
                                  nursery: state.nursery));
                            },
                          ),
                          CustomTextFormField(maxLines: 1,title: 'Image',hasTitle: true,initialValue:(state.nursery.imageUrl!=null)?state.nursery.imageUrl!:"",
                            onChanged: (value){
                            context.read<SettingsBloc>().add(UpdateSettings(nursery: state.nursery.copyWith(imageUrl: value)));
                          },
                            onFocusChanged: (hasFocus){
                              context.read<SettingsBloc>().add(UpdateSettings(
                                  isUpdateComplete: true,
                                  nursery: state.nursery));
                            },
                          ),
                          CustomTextFormField(maxLines: 1,title: 'Tags',hasTitle: true,initialValue: (state.nursery.tags!=null)?state.nursery.tags!.join(','):"",
                            onChanged: (value){
                            context.read<SettingsBloc>().add(UpdateSettings(nursery: state.nursery.copyWith(tags: value.split(","))));
                          },
                          onFocusChanged: (hasFocus){
                          context.read<SettingsBloc>().add(UpdateSettings(
                          isUpdateComplete: true,
                          nursery: state.nursery));
                          },
                          ),
                          // )
                        ],
                      );
                    }
                    else{
                      return const Text("Something went wrong");
                    }
                  }
                ),

              );
  }

  Container buildNurseryDescription(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Theme.of(context).backgroundColor,
      child: BlocBuilder<SettingsBloc,SettingsState>(
          builder: (context,state) {
            if(state is SettingsLoaded){
              return Column(
                children: [
                  Text("Nursery Description",style: Theme.of(context).textTheme.headline4,),
                  const SizedBox(height: 20,),
                  CustomTextFormField(maxLines: 5,title: 'Description',hasTitle: false,initialValue: (state.nursery.description!=null)?state.nursery.description!:"",
                    onChanged: (value){
                      context.read<SettingsBloc>().add(UpdateSettings(nursery: state.nursery.copyWith(description: value)));
                    },
                    onFocusChanged: (hasFocus){
                    context.read<SettingsBloc>().add(UpdateSettings(
                        isUpdateComplete: true,
                        nursery: state.nursery));
                    },
                  ),

                ],
              );
            }
            else{
              return const Text("Something went wrong");
            }
          }
      ),

    );
  }

  BlocBuilder<SettingsBloc, SettingsState> _buildImage() {
    return BlocBuilder<SettingsBloc,SettingsState>(
            builder: (context,state){
              if(state is SettingsLoading){
                return const SizedBox();
              }
              if(state is SettingsLoaded){
                return
                  (state.nursery.imageUrl!=null)?


                Container(
                height: 200,width: double.infinity,
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/shop1.jpg"),
                    fit: BoxFit.cover
                    ),
                  ),
                ):const SizedBox();
                }else{
                  return const Text("Something went wrong");
                }
              });
  }

}



